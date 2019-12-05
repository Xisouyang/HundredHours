//
//  NewGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class NewGoalViewController: GoalFieldsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }

    private func setupNavbar() {
        navigationItem.title = "New Goal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }

    private func createGoal() {
        guard let goalName = goalFieldsView.goalNameField.formField.textField.text,
            let goalDescription = goalFieldsView.goalDescriptionField.descriptionView.text
            else { return }
         CoreDataManager.sharedManager.createGoal(name: goalName, description: goalDescription, duration: goalDuration)
        navigationController?.popViewController(animated: true)
    }

    @objc func createTapped() {
        createGoal()
    }
}


