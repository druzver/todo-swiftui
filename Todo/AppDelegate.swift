//
//  TodoApp.swift
//  Todo
//
//  Created by Vitaly on 06.08.2022.
//

import SwiftUI

//@main
//struct TodoApp: App {
//
//    @UIApplicationDelegateAdaptor var appDelegate: TodoAppDelegate
//
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//


@main
class AppDelegate : UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
    
}
