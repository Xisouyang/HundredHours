//
//  NewGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

/* TODO -DONE:
 
        function to validate information entered is valid
            - text fields cannot be blank
            - hours must be able to be converted to an Int
                - create error view controller to show when these conditions aren't met
        function to combine goal name and hour string into 1 string
 
        store that string to tableView list in the HomeViewController
        navigate to the home view controller
 
        implement Core Data functionality to store the goal strings locally
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
    
    @objc private func createTapped() {
        createGoal()
    }
    
    private func createGoal() {
        guard let goalName = newGoalView.goalNameTextField.text else { return }
        guard let goalHours = newGoalView.goalHoursTextField.text else { return }
        let shouldPresentError = newGoalView.viewModel.checkTextFields(name: goalName, hourString: goalHours)
        if shouldPresentError {
            presentErrorView()
        } else {
            newGoalView.viewModel.addGoal(name: goalName, hourString: goalHours)
            navigationController?.initRootViewController(vc: HomeViewController())
        }
    }

    private func presentErrorView() {
        newGoalView.blurScreen()
        let errorVC = ErrorViewController()
        errorVC.modalPresentationStyle = .overFullScreen
        present(errorVC, animated: true)
    }
}


