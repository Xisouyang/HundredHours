//
//  AppDelegate.swift
//  100HoursDev
//
//  Created by Stephen Ouyang on 9/2/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

//TODO: look into a DEBUG flag to get rid of print statements

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let nav = UINavigationController()
//        let vc = HomeViewController()
//        nav.viewControllers = [vc]
//        setNavigation(navigationBar: nav.navigationBar)
//        window?.rootViewController = nav
//        window?.makeKeyAndVisible()
//        return true
        
        let nav = UINavigationController()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let onboard = OnboardViewController(collectionViewLayout: layout)
        setNavigation(navigationBar: nav.navigationBar)
        coordinator = MainCoordinator(navigationController: nav)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = onboard
        window?.makeKeyAndVisible()
        return true
    }
    
    // navigation bar UI
    func setNavigation(navigationBar: UINavigationBar) {
        let navBarTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8),
                                    NSAttributedString.Key.font: UIFont(name: "Avenir-Heavy", size: 25)]
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        appearance.prefersLargeTitles = true
        appearance.largeTitleTextAttributes = navBarTextAttributes as [NSAttributedString.Key : Any]
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

