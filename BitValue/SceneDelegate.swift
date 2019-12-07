//
//  SceneDelegate.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 04/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let marketPricesViewModel = MarketPricesViewModel(pricesViewModels: [
            PriceViewModel(date: Date(timeIntervalSince1970: 1544054400), value: 7656.995),
            PriceViewModel(date: Date(timeIntervalSince1970: 1544400000), value: 7360.544166666667),
            PriceViewModel(date: Date(timeIntervalSince1970: 1544745600), value: 7307.416666666668),
            PriceViewModel(date: Date(timeIntervalSince1970: 1545091200), value: 7314.758333333335),
            PriceViewModel(date: Date(timeIntervalSince1970: 1545436800), value: 7288.243333333335)
        ])
        
        window.rootViewController = UINavigationController(rootViewController: MarketPricesTableViewController(marketPricesViewModel: marketPricesViewModel))
        window.makeKeyAndVisible()
        
        self.window = window
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
}
