//
//  ApplicationHandler.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/5.
//

import UIKit
import CocoaLumberjack

final class ApplicationHandler {
    private static let handler = ApplicationHandler()
    static func shared() -> ApplicationHandler {
        return handler
    }
    
    private(set) var isForeground: Bool = false
    private(set) var isActive: Bool = false

    private weak var applicationDelegate: AppDelegate?
    private weak var sceneDelegate: AnyObject?
    var window: UIWindow? {
        if #available(iOS 13, *) {
            return (sceneDelegate as? SceneDelegate)?.window
        } else {
            return UIApplication.shared.keyWindow ?? applicationDelegate?.window
        }
    }

    @available(iOS 13, *)
    func applicationDidFinishLaunch(_ delegate: SceneDelegate) {
        sceneDelegate = delegate
        applicationDidFinishLaunch()
    }

    func applicationDidFinishLaunch(_ delegate: AppDelegate) {
        applicationDelegate = delegate
        applicationDidFinishLaunch()
    }

    private func applicationDidFinishLaunch() {
        initUMeng()
        initDebugTools()
    }

    func applicationDidBecomeActive() {
        isActive = true
    }
    func applicationWillResignActive() {
        isActive = false
    }
    func applicationWillEnterForeground() {
        isForeground = true
    }
    func applicationDidEnterBackground() {
        isForeground = false
    }
}

// MARK: Init 3rd SDK
extension ApplicationHandler: DDRegisteredDynamicLogging {

    private func initUMeng() {
        guard let appkey = PlistReader.getUMengAppKey(), appkey.count > 0 else { return }

        UMConfigure.initWithAppkey(appkey, channel: "AppStore")
        MobClick.setAutoPageEnabled(true)
        #if DEBUG
        UMConfigure.setLogEnabled(true)
        UMCommonLogManager.setUp()
        #endif
    }

    private func initDebugTools() {
        #if DEBUG || ADHOC
        YKWoodpeckerManager.sharedInstance().safePluginMode = false
        #else
        YKWoodpeckerManager.sharedInstance().safePluginMode = true
        #endif
        YKWoodpeckerManager.sharedInstance().show()

        if #available(iOS 13, *) {
            fixYKWCustomWindowInvisible()
            NotificationCenter.default
                .addObserver(forName: UIScene.willConnectNotification, object: nil, queue: .main) { note in
                self.fixYKWCustomWindowInvisible(windowScene: note.object as? UIWindowScene)
            }
        }

        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log

        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    static var ddLogLevel: DDLogLevel {
        get {
            #if DEBUG || ADHOC
            return DDLogLevel.all
            #else
            return DDLogLevel.info
            #endif
        }
        set {
            print("\(newValue)")
        }
    }

    @available(iOS 13, *)
    private func fixYKWCustomWindowInvisible(windowScene: UIWindowScene? = nil) {
        let value = YKWoodpeckerManager.sharedInstance().value(forKey: "_pluginsEntrance")
        guard let ykWindow = value as? YKWPluginsWindow else { return }

        if let scene = windowScene {
            ykWindow.windowScene = scene
        } else {
            for windowScene in UIApplication.shared.connectedScenes
                where windowScene.activationState == UIScene.ActivationState.foregroundActive {
                ykWindow.windowScene = windowScene as? UIWindowScene
            }
        }
    }
}
