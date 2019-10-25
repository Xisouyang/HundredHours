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
    
    func start() {
        navController.delegate = self
        let vc = HomeViewController()
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    
    func createNewGoal() {
        let vc = NewGoalViewController()
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    
    func goToDetailScreen(goal: Goal) {
        let vc = DetailViewController()
        vc.coordinator = self
        vc.goal = goal
        navController.pushViewController(vc, animated: true)
    }
    
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
