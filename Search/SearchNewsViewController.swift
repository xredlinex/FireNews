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
        if let keyword = searchNewsTextField.text, keyword != "" , let fromDate = fromDateTextField.text, let toDate = toDateTextField.text {
            getRequest(keyword, from: fromDate, to: toDate)
        } else {
            showAlertErrorMessage("Emty Search Field")
        }
    }
}


extension SearchNewsViewController {
    
    func getRequest(_ keyword: String, from: String, to: String) {
        
        parameters["q"] = keyword
        parameters["pageSize"] = 100
        if from != "" || to != "" {
            if checkDateFormat(from) == true && checkDateFormat(to) == true {
                if from < to {
                    parameters["from"] = from
                    parameters["to"] = to
                    request.newsRequest(parameters)
                } else {
                    showAlertErrorMessage("Wrong Period")
                }
            } else {
                showAlertErrorMessage("Wrong Period")
                fromDateTextField.text = ""
                toDateTextField.text = ""
            }
        } else {
            request.newsRequest(parameters)
        }
    }
}


