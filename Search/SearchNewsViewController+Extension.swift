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
        bottomHeightConstraint.constant = 300
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fromDateTextField || textField == toDateTextField{
            if textField.text?.count == 4 || textField.text?.count == 5  || textField.text?.count == 7 {
                if string != "" {
                    textField.text = textField.text! + "-"
                }
            }
            return !(textField.text!.count > 9 && string.count > range.length)
        } else {
            return true
        }
    }
}






//  MARK: - ACTIVITY INDICATOR-
extension SearchNewsViewController {
    
    func showActivityIndicator() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .white
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
//
////  MARK: - ALERT CONTROLLER -
//extension SearchNewsViewController {
//    func showErrorAlert(_ message: String) {
//        view.isUserInteractionEnabled = true
//        activityIndicatorView.stopAnimating()
//        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
//        }
//        alertController.addAction(alertAction)
//        present(alertController, animated: true)
//    }
//}

//  MARK: - ADD NEXT DONE BUTTONS TO NUMBER PAD - 
extension SearchNewsViewController {
    func addNextButtonFromDate() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let nextToolBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextBarButtonFromDate))
        let label = UIBarButtonItem(title: "dashes '-' are added automatically", style: .plain, target: self, action: nil)
        label.tintColor = UIColor.systemPurple
        toolBar.setItems([nextToolBarButton, label], animated: false)
        fromDateTextField.inputAccessoryView = toolBar
    }
    func addDoneButtonToDate() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneToolBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBarButtonToDate))
        let label = UIBarButtonItem(title: "dashes '-' are added automatically", style: .plain, target: self, action: nil)
        label.tintColor = UIColor.systemPurple
        toolBar.setItems([doneToolBarButton, label], animated: false)
        toDateTextField.inputAccessoryView = toolBar
    }
    @objc func nextBarButtonFromDate() {
        toDateTextField.becomeFirstResponder()
    }
    @objc func doneBarButtonToDate() {
        toDateTextField.resignFirstResponder()
        bottomHeightConstraint.constant = 0
    }
}

extension SearchNewsViewController {
    func uiElementh() {
        
        if let imgUrl = URL(string: "https://media.giphy.com/media/yoJC2p5X89p30jl9gQ/giphy.gif") {
            newsLogoImageView.kf.setImage(with: imgUrl)
        } else {
            newsLogoImageView.image = UIImage(named: "staticLogo")
        }
        
        searchView.clipsToBounds = true
        fromDateView.clipsToBounds = true
        toDateView.clipsToBounds = true
        searchButton.clipsToBounds = true
        searchView.layer.cornerRadius = 12
        fromDateView.layer.cornerRadius = 12
        toDateView.layer.cornerRadius = 12
        searchButton.layer.cornerRadius = 12
    }
}

//  MARK: - KEYBOARD ACTION - 
extension SearchNewsViewController {
    @objc func keyboardWillHide() {
        bottomHeightConstraint.constant = 0
        self.view.endEditing(true)
    }
}

