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
    var activityIndicatorView = UIActivityIndicatorView()
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


////  MARK: - ALAMOFIRE -
//extension SearchNewsViewController  {
//
//    func searchNews(_ keyword: String,_ fromDate: String? = nil,_ toDate: String? = nil) {
//        showActivityIndicator()
//        let parameters = ["q" : keyword,
//                          "from" : fromDate ?? "",
//                          "to" : toDate ?? "",
//                          "pageSize": "100"]
//
//        let url = URL(string: "https://newsapi.org/v2/everything")
//        if let recieveUrl = url {
//            Alamofire.request(recieveUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
//                if let recieveNews = response.result.value?.articles {
//                    if recieveNews.count != 0 {
//                        self.news  = recieveNews
//                        DispatchQueue.main.async {
//                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
//                                viewController.news = self.news
//                                viewController.parameters = parameters
//                                self.hideActivityIndicator()
//                                self.navigationController?.pushViewController(viewController, animated: true)
//                            }
//                    } else {
//                        self.showErrorAlert("Can't find news for keyword - \(keyword), or wron time period")
//                    }
//                } else {
//                    self.showErrorAlert("Wrong date period, please enter correct date, or left field empty.")
//
//                }
//            }
//        } else {
//            showErrorAlert("fatal error")
//        }
//    }
//}
//


