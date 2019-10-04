//
//  NewGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

/* numpad keyboard when user interact with hours text field */

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

//TODO: prompt the user to start typing tight away and maybe add a placeholder too on the textfields.

class NewGoalViewController: UIViewController {
    
    let newGoalView = NewGoalView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Goal"
        newGoalView.frame = view.frame
        newGoalView.defaultButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        view.addSubview(newGoalView)
        NotificationCenter.default.addObserver(self, selector: #selector(resetScreen), name: Notification.Name("errorVC dismissed"), object: nil)
    }
    
    @objc private func createTapped() {
        createGoal()
    }
    
    private func createGoal() {
        //TODO: combine the two guard lets into one
        guard let goalName = newGoalView.goalNameTextField.text else { return }
        guard let goalHours = newGoalView.goalHoursTextField.text else { return }
        let shouldPresentError = newGoalView.viewModel.checkTextFields(name: goalName, hourString: goalHours)
        if shouldPresentError {
            presentErrorView()
        } else {
            newGoalView.viewModel.addGoal(name: goalName, hourString: goalHours)
            //TODO: this should be the same animation as hitting the back button, you might need a delegate to refresh the goal view
            navigationController?.initRootViewController(vc: HomeViewController())
        }
    }

    private func presentErrorView() {
        newGoalView.addBlur()
        let errorVC = ErrorViewController()
        //TODO: find out a way to have the nav bar blur as well
        errorVC.modalPresentationStyle = .overFullScreen
        present(errorVC, animated: true)
    }
    
    @objc func resetScreen(notification: Notification) {
        newGoalView.removeBlur()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("errorVC dismissed"), object: nil)
    }
}


