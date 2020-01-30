//
//  SortFilterViewController.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class SortFilterViewController: UIViewController {

    var news: [NewsArticlesModel] = []
    var parameters: [String : String] = [:]
    
    @IBOutlet weak var sortByDateView: UIView!
    @IBOutlet weak var sortByTitleView: UIView!
    
    @IBOutlet weak var sortByDateImageView: UIImageView!
    @IBOutlet weak var sortByTitleImageView: UIImageView!
    
    var sortByDateFlag = Bool()
    var sortByTitleFlag = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortCircle()
        updateUi()
        debugPrint(parameters)
    }
    
    @IBAction func didTapGoBackButtin(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func didTapSortByDateActionButton(_ sender: Any) {
        sortCircle(sortDate: true)
        parameters["sortBy"] = "publishedAt"
        sortRequest(parameters)
        
          
    
//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
//        viewController.news = news.sorted(by: { $0.publishedAt ?? "" < $1.publishedAt ?? "" })
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
     @IBAction func didTapSortByTitleActionButton(_ sender: Any) {
        sortCircle(sortTitle: true)
        parameters["sortBy"] = "relevancy"
        sortRequest(parameters)
        
    
//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
//        viewController.news = news.sorted(by: { $0.title ?? "" < $1.title ?? ""})
//        navigationController?.pushViewController(viewController, animated: true)
     }
}

extension SortFilterViewController {
    func updateUi() {
        sortByDateView.clipsToBounds = true
        sortByTitleView.clipsToBounds = true
        sortByDateView.layer.cornerRadius = 12
        sortByTitleView.layer.cornerRadius = 12
    }
}

extension SortFilterViewController {
    
    func sortCircle(sortDate: Bool? = nil, sortTitle: Bool? = nil) {
        
        if sortDate == true {
            sortByDateImageView.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            sortByDateImageView.image = UIImage(systemName: "circle")
        }
        if sortTitle == true {
            sortByTitleImageView.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            sortByTitleImageView.image = UIImage(systemName: "circle")
        }
    }
}


extension SortFilterViewController {
    func sortRequest(_ parameters: [String : String]) {
        
        let url = URL(string: "https://newsapi.org/v2/everything")
        if let recieveUrl = url {
            Alamofire.request(recieveUrl,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding.default,
                              headers: ["X-Api-Key": "4ea21ee288f24ae880ef13ebda15edbd"]).responseObject { (response: DataResponse<NewsModel>) in
                                if let recieveNews = response.result.value?.articles {
                                    if recieveNews.count != 0 {
                                        self.news = recieveNews
                                        DispatchQueue.main.async {
                                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let viewController = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                                            viewController.news = self.news
                                            viewController.parameters = self.parameters
                                            self.navigationController?.pushViewController(viewController, animated: true)
                                        }
                                        
                                    } else {
                                        debugPrint("no news")
                                    }
                                    
                                }
            }
        } else {
            debugPrint("error")
        }
        
        
        
    }
}
