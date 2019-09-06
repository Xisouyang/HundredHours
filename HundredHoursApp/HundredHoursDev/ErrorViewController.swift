//
//  TextErrorViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/6/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let errorView = ErrorView(frame: view.frame)
        view.addSubview(errorView)
    }
}
