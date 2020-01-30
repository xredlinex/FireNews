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
    
    func newsRequest(_ parameters: [String: String], sortByTitle: Bool? = nil) {
        
        let url = URL(string: "https://newsapi.org/v2/everything")
        if let recieveUrl = url {
            Alamofire.request(recieveUrl,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding.default,
                              headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
                if let news = response.result.value?.articles {
                    if news.count != 0 {
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                            if sortByTitle == true {
                                viewController.news = news.sorted(by: { $0.title ?? "" < $1.title ?? ""})
                                viewController.parameters = parameters
                            } else {
                                viewController.news = news
                                viewController.parameters = parameters
                            }
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    } else {
                        self.showAlertErrorMessage("Can't find news for keyword - \(String(describing: parameters["q"])), or wrong date period )")
                    }
                } else {
                    self.showAlertErrorMessage("Wrong date period, please enter correct date or left empty date fields")
                }
            }
        } else {
            showAlertErrorMessage("Fatal Error")
        }
    }
}



