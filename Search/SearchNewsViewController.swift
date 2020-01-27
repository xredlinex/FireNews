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

class SearchNewsViewController: UIViewController {
    
    @IBOutlet weak var searchNewsTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!
    
    let datePicker = UIDatePicker()
    var activityIndicatorView = UIActivityIndicatorView()
    var news: [NewsArticlesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchNewsTextField.delegate = self
        fromDateTextField.delegate = self
        toDateTextField.delegate = self
        inputDatePicker()
        addNextButtonFromDate()
        addDoneButtonToDate()
        
        
        let keyboardHide = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(keyboardHide)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        searchNewsTextField.text = ""
        fromDateTextField.text = ""
        toDateTextField.text = ""
    }
    
    @IBAction func didTapSearchNewsActionButton(_ sender: Any) {
        if let keyword = searchNewsTextField.text, keyword != "", let fromDate = fromDateTextField.text, let toDate = toDateTextField.text {
            searchNews(keyword, fromDate, toDate)
        } else {
            showErrorAlert("Empty Search Fields!")
        }
    }
}

//  MARK: - ALAMOFIRE -
extension SearchNewsViewController  {
    
    func searchNews(_ keyword: String,_ fromDate: String? = nil,_ toDate: String? = nil) {
        showActivityIndicator()

        let parameters = ["q" : keyword,
                          "from" : fromDate ?? "",
                          "to" : toDate ?? "",
                          "pageSize": "100"]
        
        let url = URL(string: "https://newsapi.org/v2/everything")
        if let recieveUrl = url {
            
            Alamofire.request(recieveUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
                if let recieveNews = response.result.value?.articles {
                    if recieveNews.count != 0 {
                        debugPrint(recieveNews.count)
                        self.news  = recieveNews
                        DispatchQueue.main.async {
                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                                viewController.news = self.news
                                self.hideActivityIndicator()
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                    } else {
                        self.showErrorAlert("Can't find news for keyword - \(keyword)")
                    }
                }

            }
        } else {
            debugPrint("ädd error")
        }
    }
}


