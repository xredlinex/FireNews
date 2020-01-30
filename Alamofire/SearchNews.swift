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
    
    func newsRequest(_ parameters: [String: String], sortByTitle: Bool? = nil) -> [NewsArticlesModel] {

        var news: [NewsArticlesModel] = []

        
        let url = URL(string: "https://newsapi.org/v2/everything")
        if let recieveUrl = url {
            Alamofire.request(recieveUrl,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding.default,
                              headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
                if let recieveNews = response.result.value?.articles {
                    if recieveNews.count != 0 {
                        if sortByTitle == true {
                            news = recieveNews.sorted(by: { $0.title ?? "" < $1.title ?? ""})
                        } else {
                            news = recieveNews
                        }
                    } else {
                        self.showAlertErrorMessage("Can't find news for keyword - \(parameters["q"] ?? "---"), or wrong date period )")
                    }
                } else {
                    self.showAlertErrorMessage("Wrong date period, please enter correct date or left empty date fields")
                }
            }
        } else {
            showAlertErrorMessage("Fatal Error")
        }
        return news
    }
}



