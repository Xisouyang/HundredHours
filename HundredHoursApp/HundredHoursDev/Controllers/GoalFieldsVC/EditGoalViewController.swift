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
    private let viewModel = EditGoalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrappedGoal = goal else { return }
        goalDuration = viewModel.editGoalDuration(goal: unwrappedGoal)
        setupNavbar()
        setupView()
    }

    private func setupView() {
        didSetDatePicker = true
        goalFieldsView.goalNameField.formField.textField.text = goal?.title
        goalFieldsView.goalDescriptionField.descriptionView.text = goal?.goalDescription
        goalFieldsView.goalDescriptionField.descriptionView.textColor = UIColor.black
    }

    private func setupNavbar() {
        navigationItem.title = "Edit Goal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }

    @objc func editTapped() {
        editGoal()
    }

    private func editGoal() {
        guard let unwrappedGoal = goal,
            let goalTitle = goalFieldsView.goalNameField.formField.textField.text,
            let goalDescription = goalFieldsView.goalDescriptionField.descriptionView.text
            else { return }
        CoreDataManager.sharedManager.updateGoal(goal: unwrappedGoal, name: goalTitle, description: goalDescription, duration: goalDuration)
        navigationController?.popViewController(animated: true)
    }
}
