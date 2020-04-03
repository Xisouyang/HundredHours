//
//  GoalFieldsViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 12/3/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
import UIKit

class GoalFieldsViewController: UIViewController {

    weak var coordinator: Coordinator?
    let newGoalView = NewGoalView()
    var goalDuration: Int = 0
    var didSetDatePicker: Bool = false
    private var keyboardHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupView()
    }

    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(newGoalView)
        newGoalView.frame = view.frame
        newGoalView.goalNameField.formField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        newGoalView.goalDurationField.formField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        newGoalView.goalNameField.formField.delegate = self
        newGoalView.goalDurationField.formField.delegate = self
        newGoalView.goalDescriptionView.delegate = self
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
            keyboardHeight = keyboardSize.height
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

    //FIX
    private func validateTextFields() {
        guard
            let nameField = newGoalView.goalNameField.formField.text,
            !nameField.isEmpty, let descriptionField = newGoalView.goalDescriptionView.text, (descriptionField != "Describe Goal.." && !descriptionField.isEmpty), let durationField = newGoalView.goalDurationField.formField.text, !durationField.isEmpty, let _ = Int(durationField)
            else {
                newGoalView.startButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
                newGoalView.startButton.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                newGoalView.startButton.isEnabled = false
                return
        }
        newGoalView.startButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        newGoalView.startButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        newGoalView.startButton.isEnabled = true
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

extension GoalFieldsViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 30
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        newGoalView.goalDescriptionView.becomeFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.view.frame.origin.y < 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y = 0
            })
        }
        if textField == newGoalView.goalDurationField.formField {
            let line = newGoalView.goalDurationField.formLine
            newGoalView.highlightLine(line: line)
        } else if textField == newGoalView.goalNameField.formField {
            let line = newGoalView.goalNameField.formLine
            newGoalView.highlightLine(line: line)
        }
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == newGoalView.goalDurationField.formField {
            if let string = textField.text, let num = Int(string) {
                goalDuration = num
            }
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == newGoalView.goalDurationField.formField {
            let line = newGoalView.goalDurationField.formLine
            newGoalView.unhighlightLine(line: line)
        } else if textField == newGoalView.goalNameField.formField {
            let line = newGoalView.goalNameField.formLine
            newGoalView.unhighlightLine(line: line)
        }
    }
}

extension GoalFieldsViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.view.frame.origin.y == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y -= self.keyboardHeight / 3
            })
        }
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
            textView.text = "Describe Goal.."
        }
    }
}
