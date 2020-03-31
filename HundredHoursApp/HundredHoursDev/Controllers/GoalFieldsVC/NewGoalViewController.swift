//
//  NewGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class NewGoalViewController: GoalFieldsViewController {
    
    private let notificationObj: NotificationService
    
    init(_ notificationObj: NotificationService) {
        self.notificationObj = notificationObj
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let notificationID = notificationObj.createNotificationRequest(goalName)
        CoreDataManager.sharedManager.createGoal(name: goalName, description: goalDescription, duration: goalDuration, notificationID: notificationID)
        navigationController?.popViewController(animated: true)
    }

    @objc func createTapped() {
        createGoal()
    }
}


