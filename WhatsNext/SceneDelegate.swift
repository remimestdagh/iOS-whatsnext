//
//  SceneDelegate.swift
//  WhatsNext
//
//  Created by remi mestdagh on 08/11/2020.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard (scene as? UIWindowScene) != nil else { return }

        // add these lines
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            // if user is logged in before
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
                // instantiate the main tab bar controller and set it as root view controller
                // using the storyboard identifier we set earlier
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                window?.rootViewController = mainTabBarController
            } else {
                // if user isn't logged in
                // instantiate the navigation controller and set it as root view controller
                // using the storyboard identifier we set earlier
                let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
                window?.rootViewController = loginNavController
            }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func changeRootViewController(_ viewc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
                return
            }
            window.rootViewController = viewc
        UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft],
                              animations: nil,
                              completion: nil)
    }

}
