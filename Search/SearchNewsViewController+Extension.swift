//
//  SearchNewsViewController+Extension.swift
//  FireNews
//
//  Created by alexey sorochan on 27.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

//  MARK: - TEXT FIELD DELEGATE -
extension SearchNewsViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bottomHeightConstraint.constant = 250
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case searchNewsTextField:
            fromDateTextField.becomeFirstResponder()
        case fromDateTextField:
            toDateTextField.becomeFirstResponder()
        case toDateTextField:
            toDateTextField.resignFirstResponder()
        default:
            searchNewsTextField.becomeFirstResponder()
        }
        return true
    }
}

//  MARK: - ACTIVITY INDICATOR-
extension SearchNewsViewController {
    
    func showActivityIndicator() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .black
        activityIndicatorView.center = self.view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
    }
}

//  MARK: - ALERT CONTROLLER -
extension SearchNewsViewController {
    func showErrorAlert(_ message: String) {
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}

//  MARK: - DATA PICKER - (recieve date from date picker)
extension SearchNewsViewController {
    func inputDatePicker() {
        datePicker.datePickerMode = .date
        fromDateTextField.inputView = datePicker
        toDateTextField.inputView = datePicker
    }
    
    func addNextButtonFromDate() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let nextToolBarButton = UIBarButtonItem.init(title: "Next", style: .done, target: self, action: #selector(nextBarButtonFromDate))
        toolBar.setItems([nextToolBarButton], animated: false)
        fromDateTextField.inputAccessoryView = toolBar
    }
    
    func addDoneButtonToDate() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneToolBarButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneBarButtonToDate))
        toolBar.setItems([doneToolBarButton], animated: false)
        toDateTextField.inputAccessoryView = toolBar
    }
    
    @objc func nextBarButtonFromDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let date = dateFormatter.string(from: datePicker.date)
        fromDateTextField.text = "\(date)"
        toDateTextField.becomeFirstResponder()
    }
    
    @objc func doneBarButtonToDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let date = dateFormatter.string(from: datePicker.date)
        toDateTextField.text = "\(date)"
        toDateTextField.resignFirstResponder()
    }
}

//  MARK: - KEYBOARD ACTION - 
extension SearchNewsViewController {
    @objc func keyboardWillHide() {
        bottomHeightConstraint.constant = 0
        self.view.endEditing(true)
    }
}

