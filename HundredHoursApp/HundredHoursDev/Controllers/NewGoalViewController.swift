//
//  NewGoalViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

enum TextType {
    case goalName
    case goalDescription
}

class NewGoalViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    private let newGoalView = NewGoalView()
    // start at 1 min
    private var goalDuration: Int = 60
    private var textType: TextType = .goalName

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupNavbar()
        setupView()
    }
    
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(newGoalView)
        newGoalView.frame = view.frame
        newGoalView.goalNameField.formField.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        newGoalView.datePickerStack.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        newGoalView.goalNameField.formField.textField.delegate = self
        newGoalView.goalDescriptionField.descriptionView.delegate = self
    }
    
    private func setupNavbar() {
        navigationItem.title = "New Goal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func createGoal() {
        guard let goalName = newGoalView.goalNameField.formField.textField.text,
        let goalDescription = newGoalView.goalDescriptionField.descriptionView.text
            else { return }
        newGoalView.viewModel.addGoal(name: goalName, description: goalDescription, duration: goalDuration)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        goalDuration = newGoalView.viewModel.getTimeString(sender: sender)
    }
    
    @objc func createTapped() {
        createGoal()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if textType == .goalName {
                self.view.frame.origin.y = 0
            }  else if textType == .goalDescription {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height/2
                } else if self.view.frame.origin.y < 0 {
                    self.view.frame.origin.y -= (keyboardSize.height/3)
                }
            }
        }
    }
    
    @objc func editingChanged(textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        validateTextFields()
    }

    private func validateTextFields() {
        guard
            let nameField = newGoalView.goalNameField.formField.textField.text,
            !nameField.isEmpty, let descriptionField = newGoalView.goalDescriptionField.descriptionView.text, (descriptionField != "Placeholder..." && !descriptionField.isEmpty)
            else {
                navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                navigationItem.rightBarButtonItem?.isEnabled = false
                return
        }
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("errorVC dismissed"), object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

extension NewGoalViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        newGoalView.goalDescriptionField.descriptionView.becomeFirstResponder()
        textType = .goalDescription
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let line = newGoalView.goalNameField.formLine
        newGoalView.highlightLine(line: line)
        textType = .goalName
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let line = newGoalView.goalNameField.formLine
        newGoalView.unhighlightLine(line: line)
    }
}

extension NewGoalViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textType = .goalDescription
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        validateTextFields()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numOfChars = newText.count
        return numOfChars <= 100
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "Placeholder..."
        }
    }
}


