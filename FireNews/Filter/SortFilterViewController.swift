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

    @IBOutlet weak var sortByDateView: UIView!
    @IBOutlet weak var sortByTitleView: UIView!
    
    @IBOutlet weak var sortByDateImageView: UIImageView!
    @IBOutlet weak var sortByTitleImageView: UIImageView!
    
    var sortByDateFlag = Bool()
    var sortByTitleFlag = Bool()
    var request = SearchFireNews()
    var news: [NewsArticlesModel] = []
    var parameters: [String : Any] = [:]
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortCircle()
        updateUi()
        setupforActivityImdicator()
    }
    
    @IBAction func didTapGoBackButtin(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func didTapSortByDateActionButton(_ sender: Any) {
        activityIndicator.startAnimating()
        sortCircle(sortDate: true)
        parameters["sortBy"] = "publishedAt"
        request.newsRequest(parameters, activityIndicator: activityIndicator)
    }
    
     @IBAction func didTapSortByTitleActionButton(_ sender: Any) {
        activityIndicator.startAnimating()
        sortCircle(sortTitle: true)
        parameters.removeValue(forKey: "sortBy")
        request.newsRequest(parameters, activityIndicator: activityIndicator, sortByTitle: true)
     }
}




