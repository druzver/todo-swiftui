//
//  SceneDelegate.swift
//  Todo
//
//  Created by Vitaly on 06.08.2022.
//

import UIKit


class SceneDelegate : UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    var mainCoordinator: MainScreenCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }



        window = UIWindow(windowScene: windowScene)

        
        
        let navController = UINavigationController(rootViewController: UIViewController())
        
        mainCoordinator = MainScreenCoordinator(
            navController: navController,
            di: DIContainerImpl()
        )

        
        window?.rootViewController = navController
        mainCoordinator?.start()
        
        
        
        window?.makeKeyAndVisible()

        
    }
    
    
    
}
