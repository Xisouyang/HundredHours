//
//  TextErrorViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/6/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    let errorView = ErrorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.frame = view.frame
        view.addSubview(errorView)
        setupSwipeGesture()
    }
    
    func setupSwipeGesture() {
        
        let gestureDown = UISwipeGestureRecognizer()
        gestureDown.numberOfTouchesRequired = 1
        gestureDown.direction = .down
        gestureDown.addTarget(self, action: #selector(viewSwiped))
        errorView.addGestureRecognizer(gestureDown)
    }
    
    @objc func viewSwiped() {
        self.dismiss(animated: true, completion: nil)
    }
}
