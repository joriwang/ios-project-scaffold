//
//  AppDelegate.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var _window: UIWindow?
    var window: UIWindow? {
        get {
            _window ?? ApplicationHandler.shared().window
        }
        set {
            _window = newValue
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13, *) {
            return true
        }

        ApplicationHandler.shared().applicationDidFinishLaunch(self)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        ApplicationHandler.shared().applicationDidBecomeActive()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        ApplicationHandler.shared().applicationWillResignActive()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        ApplicationHandler.shared().applicationWillEnterForeground()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        ApplicationHandler.shared().applicationDidEnterBackground()
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
