//
//  AppDelegate.swift
//  MovieDB
//
//  Created by MacBook on 04/01/22.
//

import UIKit
#if DEBUG
import netfox
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navController: UINavigationController?
    var categoryViewController: CategoryViewController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
        
        window = UIWindow(frame:UIScreen.main.bounds)
        categoryViewController = CategoryViewController(nibName: String(describing: CategoryViewController.self), bundle: nil)
        navController = UINavigationController(rootViewController: categoryViewController!)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

