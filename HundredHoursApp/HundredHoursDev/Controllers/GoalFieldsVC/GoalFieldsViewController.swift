//
//  GoalFieldsViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 12/3/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
import UIKit

enum TextType {
    case goalName
    case goalDescription
}

class GoalFieldsViewController: UIViewController {

    weak var coordinator: Coordinator?
    let goalFieldsView = GoalFieldsView()
    // start at 1 min
    var goalDuration: Int = 60
    private var keyboardHeight: CGFloat = 0
    private var textType: TextType = .goalName
    private var didSetDatePicker: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupView()
        // sends this task to be done on different queue, but how does this resolve the date picker bug
        // does it really take that much time to set the date picker countdown duration?
        DispatchQueue.main.async {
            self.goalFieldsView.datePickerStack.datePicker.countDownDuration = TimeInterval(self.goalDuration)
        }
    }

    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(goalFieldsView)
        goalFieldsView.frame = view.frame
        goalFieldsView.goalNameField.formField.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        goalFieldsView.datePickerStack.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        goalFieldsView.goalNameField.formField.textField.delegate = self
        goalFieldsView.goalDescriptionField.descriptionView.delegate = self
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func datePickerValueChanged(sender: UIDatePicker) {
        didSetDatePicker = true
        goalDuration = goalFieldsView.newGoalViewModel.getTimeString(sender: sender)
        validateTextFields()
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
                    self.view.frame.origin.y -= keyboardSize.height/3
                }
            }
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

    private func validateTextFields() {
        guard
            let nameField = goalFieldsView.goalNameField.formField.textField.text,
            !nameField.isEmpty, let descriptionField = goalFieldsView.goalDescriptionField.descriptionView.text, (descriptionField != "Describe Goal.." && !descriptionField.isEmpty), didSetDatePicker == true
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

extension GoalFieldsViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        goalFieldsView.goalDescriptionField.descriptionView.becomeFirstResponder()
        textType = .goalDescription
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
        let line = goalFieldsView.goalNameField.formLine
        goalFieldsView.highlightLine(line: line)
        textType = .goalName
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let line = goalFieldsView.goalNameField.formLine
        goalFieldsView.unhighlightLine(line: line)
    }
}

extension GoalFieldsViewController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textType = .goalDescription
        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.view.frame.origin.y == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y -= self.keyboardHeight / 3
            })
        }
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
            textView.text = "Describe Goal.."
        }
    }
}
