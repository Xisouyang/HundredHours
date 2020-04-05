//
//  MainCoordinator.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/22/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var navController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navController = navigationController
    }
    
    func onboard() {
        let notificationObj = NotificationService()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        navController.delegate = self
        let vc = OnboardViewController(notificationObj, layout)
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    
    func start() {
        let notificationObj = NotificationService()
        navController.delegate = self
        let vc = HomeViewController(notificationObj)
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    
    func createNewGoal() {
        let notificationObj = NotificationService()
        let vc = NewGoalViewController(notificationObj)
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }


    //Leaving this in here for future, if I need child coordinators
    
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
//            else { return }
//        if navigationController.viewControllers.contains(fromViewController) { return }
//        //...
//    }
//
//    func childDidFinish(child: Coordinator?) {
//        for(index, coordinator) in childCoordinators.enumerated() {
//            if coordinator === child {
//                childCoordinators.remove(at: index)
//                break
//            }
//        }
//    }
}
