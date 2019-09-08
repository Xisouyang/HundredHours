//
//  UINavController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    // Removes all view controllers from navigation controller then set the new root view controller and it pops.
    
    func initRootViewController(vc: UIViewController, transitionType type: String = "kCATransitionFade", duration: CFTimeInterval = 0.35) {
        self.addTransition(transitionType: type, duration: duration)
        self.viewControllers.removeAll()
        self.pushViewController(vc, animated: false)
        self.popToRootViewController(animated: false)
    }
    
    
    // Adds the animation of navigation flow.
    
    private func addTransition(transitionType type: String = "kCATransitionFade", duration: CFTimeInterval = 0.35) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
}
