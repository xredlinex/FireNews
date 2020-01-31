//
//  SearchNewsViewController.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class SearchNewsViewController: UIViewController {
    
    @IBOutlet weak var newsLogoImageView: UIImageView!
    @IBOutlet weak var searchNewsTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var fromDateView: UIView!
    @IBOutlet weak var toDateView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    var request = SearchFireNews()
//    var activityIndicatorView = UIActivityIndicatorView()
    var news: [NewsArticlesModel] = []
    var parameters: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        uiElementh()
        
        let keyboardHide = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(keyboardHide)
        searchNewsTextField.delegate = self
        fromDateTextField.delegate = self
        toDateTextField.delegate = self
        addDoneButtonToDate()
        addNextButtonFromDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        searchNewsTextField.text = ""
        fromDateTextField.text = ""
        toDateTextField.text = ""

    }
    
    @IBAction func didTapSearchNewsActionButton(_ sender: Any) {
        showActivityIndicator()
        if let keyword = searchNewsTextField.text, keyword != "", let fromDate = fromDateTextField.text, let toDate = toDateTextField.text {
            parameters["q"] = keyword
            parameters["pageSize"] = 100
            if fromDate != "" || toDate != "" {
                if checkDateFormat(fromDate) == true && checkDateFormat(toDate) {
                    if fromDate < toDate {
                        parameters["from"] = fromDate
                        parameters["to"] = toDate
                        request.newsRequest(parameters)
                        
                    } else {
                        showAlertErrorMessage("Wrong Period")
                    }
                } else {
                    fromDateTextField.text = ""
                    toDateTextField.text = ""
                }
            } else {
                request.newsRequest(parameters)
                

            }
            
        } else {
            showAlertErrorMessage("Empty Search Field!")
        }
    }
}





