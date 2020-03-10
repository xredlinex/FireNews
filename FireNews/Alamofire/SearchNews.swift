//
//  SearchNews.swift
//  FireNews
//
//  Created by alexey sorochan on 30.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper

class SearchFireNews: UIViewController {
    
    func newsRequest(_ parameters: [String: Any], activityIndicator: UIActivityIndicatorView, sortByTitle: Bool? = nil) {
    
        var news: [NewsArticlesModel] = []
        
        let url = URL(string: "https://newsapi.org/v2/everything")
        if let recieveUrl = url {
            activityIndicator.startAnimating()
            Alamofire.request(recieveUrl,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding.default,
                              headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
                activityIndicator.stopAnimating()
                if let recieveNews = response.result.value?.articles {
                    if recieveNews.count != 0 {
                        if sortByTitle == true {
                            news = recieveNews.sorted(by: { $0.title ?? "" < $1.title ?? ""})
                            self.transferControll(news, parameters: parameters)
                        } else {
                           news = recieveNews
                            self.transferControll(news, parameters: parameters)
                        }
                    } else {
                        self.showAlertErrorMessage("Can't find news for keyword - \(parameters["q"] ?? "---"), or wrong date period )")
                    }
            
                } else {
                    self.showAlertErrorMessage("Responce Error")
                }
            }
        } else {
            showAlertErrorMessage("Fatal Error")
        }
    }
}



