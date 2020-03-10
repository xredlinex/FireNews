//
//  SearchNewsViewController+Extension.swift
//  FireNews
//
//  Created by alexey sorochan on 27.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

//      MARK:- GET REQUEST -
 extension SearchNewsViewController {
     
     func getRequest(_ keyword: String, from: String, to: String) {
         
         parameters["q"] = keyword
         parameters["pageSize"] = 100
         if from != "" || to != "" {
             if checkDateFormat(from) == true && checkDateFormat(to) == true {
                 if from < to {
                     parameters["from"] = from
                     parameters["to"] = to
                     request.newsRequest(parameters, activityIndicator: activityIndicator)
                 } else {
                     showAlertErrorMessage("Wrong Period")
                 }
             } else {
                 showAlertErrorMessage("Wrong Period")
                 fromDateTextField.text = ""
                 toDateTextField.text = ""
             }
         } else {
             request.newsRequest(parameters, activityIndicator: activityIndicator)
         }
     }
 }

//  MARK: - CHECK DATA FORMAT -
extension SearchNewsViewController {
    func checkDateFormat(_ date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let stringDate = dateFormatter.date(from: date) {
            debugPrint(stringDate)
            return true
        } else {
            if date != "" {
                showAlertErrorMessage("Wrong data format! Enter Date type yyyy-mm-dd")
            }
        }
        return false
    }
}

//  MARK: - TEXT FIELD DELEGATE -
extension SearchNewsViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bottomHeightConstraint.constant = 270
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
        
        if textField == fromDateTextField || textField == toDateTextField, let text = textField.text, !text.isEmpty {
            if (4...5) ~= text.count || text.count == 7 {
                textField.text = textField.text! + "-"
            }
            return !(textField.text!.count > 9 && string.count > range.length)
        } else {
            return true
        }
    }
}

//  MARK: - ADD NEXT DONE BUTTONS TO NUMBER PAD - 
extension SearchNewsViewController {
    
    func addNextButtonFromDate() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let nextToolBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextBarButtonFromDate))
        let label = UIBarButtonItem(title: "dashes '-' are added automatically", style: .plain, target: self, action: nil)
        toolBar.layer.backgroundColor = UIColor.systemPurple.cgColor
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

        if let imgUrl = URL(string: "https://media.giphy.com/media/2wNOCAfEfEpG0/giphy.gif") {
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

extension SearchNewsViewController {
    
    func setupForActivityIndicator() {
        
        activityIndicator.style = .medium
        activityIndicator.color = .systemPurple
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
    }
}
