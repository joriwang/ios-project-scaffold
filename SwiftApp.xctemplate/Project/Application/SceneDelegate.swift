//
//  SceneDelegate.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/5.
//

import UIKit

@available(iOS 13, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        ApplicationHandler.shared().applicationDidFinishLaunch(self)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        ApplicationHandler.shared().applicationDidBecomeActive()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        ApplicationHandler.shared().applicationWillResignActive()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        ApplicationHandler.shared().applicationWillEnterForeground()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        ApplicationHandler.shared().applicationDidEnterBackground()
    }


}

