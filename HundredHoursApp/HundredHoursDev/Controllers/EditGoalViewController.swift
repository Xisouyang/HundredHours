//
//  EditGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 12/3/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class EditGoalViewController: GoalFieldsViewController {

    var goal: Goal?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
    }

    private func setupView() {
        goalFieldsView.goalNameField.formField.textField.text = goal?.title
        goalFieldsView.goalDescriptionField.descriptionView.text = goal?.goalDescription
        goalFieldsView.goalDescriptionField.descriptionView.textColor = UIColor.black
    }

    private func setupNavbar() {
        navigationItem.title = "Edit Goal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }

    @objc func editTapped() {
        guard let unwrappedGoal = goal else { return }
        CoreDataManager.sharedManager.removeItem(objectID: unwrappedGoal.objectID)
        createGoal()
    }
}
