//
//  NewGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

/* TODO:
 
        function to validate information entered is valid
            - text fields cannot be blank
            - hours must be able to be converted to an Int
                - create error view controller to show when these conditions aren't met
        function to combine goal name and hour string into 1 string
 
        store that string to tableView list in the HomeViewController
        navigate to the home view controller
 
        Implement Core Data functionality to store the goal strings locally
 */


class NewGoalViewController: UIViewController {
    
    let newGoalView = NewGoalView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Goal"
        newGoalView.frame = view.frame
        newGoalView.defaultButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        view.addSubview(newGoalView)
    }
    
    @objc func createTapped() {
        print("tapped")
    }
}
