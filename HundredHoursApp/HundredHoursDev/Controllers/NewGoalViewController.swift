//
//  NewGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

/* numpad keyboard when user interact with hours text field */

class NewGoalViewController: UIViewController, UITextFieldDelegate {
    
    private let newGoalView = NewGoalView()
    private var isGoalName = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupView()
    }
    
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        navigationItem.title = "New Goal"
        newGoalView.frame = view.frame
        newGoalView.defaultButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        newGoalView.goalNameField.formField.textField.delegate = self
        newGoalView.goalHourField.formField.textField.delegate = self
        view.addSubview(newGoalView)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetScreen), name: Notification.Name("errorVC dismissed"), object: nil)
    }
    
    private func createGoal() {
        guard let goalName = newGoalView.goalNameField.formField.textField.text, let goalHours = newGoalView.goalHourField.formField.textField.text else { return }
        let shouldPresentError = newGoalView.viewModel.checkTextFields(name: goalName, hourString: goalHours)
        if shouldPresentError {
            presentErrorView()
        } else {
            newGoalView.viewModel.addGoal(name: goalName, hourString: goalHours)
            navigationController?.popViewController(animated: true)
        }
    }

    private func presentErrorView() {
        newGoalView.addBlur()
        let errorVC = ErrorViewController()
        //TODO: find out a way to have the nav bar blur as well
        errorVC.modalPresentationStyle = .overFullScreen
        present(errorVC, animated: true)
    }
    
    @objc private func createTapped() {
        createGoal()
    }
    
    @objc func resetScreen(notification: Notification) {
        newGoalView.removeBlur()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == newGoalView.goalNameField.formField.textField {
            newGoalView.goalNameField.formField.textField.resignFirstResponder()
            newGoalView.goalHourField.formField.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == newGoalView.goalNameField.formField.textField {
            isGoalName = true
            let line = newGoalView.goalNameField.formLine
            newGoalView.highlightLine(line: line)
        } else if textField == newGoalView.goalHourField.formField.textField {
            let line = newGoalView.goalHourField.formLine
            newGoalView.highlightLine(line: line)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isGoalName = false
        if textField == newGoalView.goalNameField.formField.textField {
            let line = newGoalView.goalNameField.formLine
            newGoalView.unhighlightLine(line: line)
        } else if textField == newGoalView.goalHourField.formField.textField {
            let line = newGoalView.goalHourField.formLine
            newGoalView.unhighlightLine(line: line)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isGoalName == false {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= (keyboardSize.height/2)
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("errorVC dismissed"), object: nil)
    }
}


