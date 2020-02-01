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
        showActivityIndicator()
        request.newsRequest(parameters)
    }
    
     @IBAction func didTapSortByTitleActionButton(_ sender: Any) {
        sortCircle(sortTitle: true)
        parameters.removeValue(forKey: "sortBy")
        showActivityIndicator()
        request.newsRequest(parameters, sortByTitle: true)
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
