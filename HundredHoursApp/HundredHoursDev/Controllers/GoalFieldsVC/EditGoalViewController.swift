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
        setupView()
    }

    private func setupView() {
        newGoalView.goalNameField.formField.text = goal?.title
        newGoalView.goalDescriptionView.text = goal?.goalDescription
        newGoalView.goalDescriptionView.textColor = UIColor.white
    }

    @objc func editTapped() {
        editGoal()
    }

    private func editGoal() {
        guard let unwrappedGoal = goal,
            let goalTitle = newGoalView.goalNameField.formField.text,
            let goalDescription = newGoalView.goalDescriptionView.text
            else { return }
        CoreDataManager.sharedManager.updateGoal(goal: unwrappedGoal, name: goalTitle, description: goalDescription, duration: goalDuration)
        navigationController?.popViewController(animated: true)
    }
}
