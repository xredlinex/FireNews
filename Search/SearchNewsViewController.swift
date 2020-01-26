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
    
    var activityIndicatorView = UIActivityIndicatorView()
    var news: [NewsArticlesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    @IBAction func didTapSearchNewsActionButton(_ sender: Any) {
        searchNews("penis")

        
    }
}

extension SearchNewsViewController: UITextFieldDelegate {
    
}

extension SearchNewsViewController  {
    
    func searchNews(_ keyword: String,_ fromDate: String? = nil,_ toDate: String? = nil) {
        showActivityIndicator()
        let parameters = ["q" : keyword,
//                          "from" : fromDate,
//                          "to" : toDate,
                          "pageSize": "100"]
        
        let url = URL(string: "https://newsapi.org/v2/everything")
        if let recieveUrl = url {
            Alamofire.request(recieveUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
                if let recieveNews = response.result.value?.articles {
                    if recieveNews.count != 0 {
                        self.news  = recieveNews
                        DispatchQueue.main.async {
                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                                viewController.news = self.news
                                self.hideActivityIndicator()
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                        
                    } else {
                        debugPrint("error url")
                        self.showErrorAlert()
                    }
                }

            }
        } else {
            debugPrint("ädd error")
        }
    }
}


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

extension SearchNewsViewController {
    func showErrorAlert() {
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
    }
}
