//
//  AppDelegate.swift
//  100HoursDev
//
//  Created by Stephen Ouyang on 9/2/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

//TODO: Fix bug that occurs when number of hours is too large - done
//TODO: Add description view to app - done
/*
 add description view (UITextView) to goal list on front page
 create stack view for description label and description view - class component
 add class component to the new goals page
 change core data model to accept the description view
 */
//TODO: Fix spacing bug on list view - done
//TODO: Maybe change buttons to move to top right corner - done
//TODO: Autosizing goal cells - done
//TODO: size of UILabel in goal cell to display goal name properly - done


// TODO: look into a DEBUG flag to get rid of print statements
// TODO: Maybe fix character limit

// TODO: Add Edit goals page to app
// TODO: Add image to empty state view
// TODO: Blur out cards that have been completed
// TODO: Darken screen as you drag time stamps view up, brighten as drag down
// TODO: Add notification center to app

//TODO: Be able to add specific notification when user creates the goal - done
//TODO: Automatically remove the notification when user completes the goal - done
    /* -Can make the notification id a part of the Core Data
       -When the percentage == 100, that's when we remove the notification request for that goal
            -Can access through the notification id property in the goal object in Core Data
    */
//TODO: If user deletes the goal, remove the notification associated with it - done
//TODO: Add sound to notification - done
//TODO: Figure out how to increment badge count
  

//TODO: Fix GoalCollectionCell to look like the mocks
    //TODO: Update UI - remove the card format, delete the options button - done
    //TODO: Delete DetailVC, Detail View and Edit VC
    //TOOD: Move the progress bar circle over to the GoalCollectionCell
    //TODO: Move timer functionality to GoalCollectionCell
        //TODO: Move functionality to start timer in feed view - done
        //TODO: move functionality to update once timer ends to feed view

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let nav = UINavigationController()
        configNavigation(nav)
        coordinator = MainCoordinator(navigationController: nav)
        if UserDefaults.standard.object(forKey: "onboarded") as? Bool == true {
            coordinator?.start()
        } else {
            coordinator?.onboard()
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
    
    // navigation bar UI
    func configNavigation(_ nav: UINavigationController) {
        let navBarTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 32)]
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = #colorLiteral(red: 0.6728389859, green: 0, blue: 1, alpha: 1)
            appearance.largeTitleTextAttributes = navBarTextAttributes as [NSAttributedString.Key : Any]
            appearance.titleTextAttributes = navBarTextAttributes as [NSAttributedString.Key : Any]
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.scrollEdgeAppearance = appearance
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationBar.tintColor = .white
        } else {
            let appearance = UINavigationBar.appearance()
            appearance.barTintColor = #colorLiteral(red: 0.668626368, green: 0, blue: 1, alpha: 1)
            appearance.prefersLargeTitles = true
            appearance.largeTitleTextAttributes = navBarTextAttributes as [NSAttributedString.Key : Any]
        }
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

