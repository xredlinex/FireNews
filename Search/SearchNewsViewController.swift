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
    
    var news: [NewsArticlesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapSearchNewsActionButton(_ sender: Any) {
        searchNews("tenis")

        
    }
}

extension SearchNewsViewController: UITextFieldDelegate {
    
}

extension SearchNewsViewController  {
    
    func searchNews(_ keyword: String,_ fromDate: String? = nil,_ toDate: String? = nil) {
        
        let parameters = ["q" : keyword,
//                          "from" : fromDate,
//                          "to" : toDate,
                          "pageSize": "100"]
        
        let url = URL(string: "https://newsapi.org/v2/everything")
        if let recieveUrl = url {
            Alamofire.request(recieveUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
                if let recieveNews = response.result.value?.articles {
                    self.news = recieveNews
                    DispatchQueue.main.async {
                        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                        viewController.news = self.news
                        self.navigationController?.pushViewController(viewController, animated: true)
                        
                    }
                }
            }
        } else {
            debugPrint("ädd error")
        }
    }
}

