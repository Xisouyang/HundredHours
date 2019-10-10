//
//  TextErrorViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/6/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.

import UIKit

class ErrorViewController: UIViewController {
    
    private let errorView = ErrorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        errorView.frame = view.frame
        view.addSubview(errorView)
        errorView.tapGesture.addTarget(self, action: #selector(viewTapped))
    }
    
    @objc func viewTapped() {
        NotificationCenter.default.post(name: Notification.Name("errorVC dismissed"), object: self)
        self.dismiss(animated: true, completion: nil)
    }
}
