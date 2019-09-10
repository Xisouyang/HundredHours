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
    
    @objc func createTapped() {
        
        let shouldPresentError = checkTextFields()
        if shouldPresentError {
            
            presentErrorView()
        } else {
            
            addGoal()
            navigationController?.initRootViewController(vc: HomeViewController())
        }
    }
    
    func checkTextFields() -> Bool {
        
        var shouldPresentError = false
        
        if newGoalView.goalNameTextField.text == "" ||
            newGoalView.goalHoursTextField.text == "" {
            
            shouldPresentError = true
        }
        
        guard let unwrappedHoursCheck = newGoalView.goalHoursTextField.text else {
            
            shouldPresentError = true
            return shouldPresentError
        }
        if Int(unwrappedHoursCheck) == nil {
            
            shouldPresentError = true
        }
        
        return shouldPresentError
    }
    
    func presentErrorView() {
        let errorVC = ErrorViewController()
        errorVC.modalPresentationStyle = .overFullScreen
        present(errorVC, animated: true)
    }
    
    func addGoal() {
        
        guard let goalName = newGoalView.goalNameTextField.text else { return }
        guard let goalHoursString = newGoalView.goalHoursTextField.text else { return }
        guard let goalHours = Int(goalHoursString) else { return }
        
        
        CoreDataManager.sharedManager.createGoal(name: goalName, hours: goalHours)
    }
}

//    func getGoalString(goalName: String, goalHours: String) -> String {
//
//        var result: String = ""
//
//        if Int(goalHours) == 1 {
//            result = goalName + " - " + goalHours + " HOUR"
//        } else {
//            result = goalName + " - " + goalHours + " HOURS"
//        }
//        return result
//    }


