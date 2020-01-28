//
//  SortFilterViewController.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class SortFilterViewController: UIViewController {

    var news: [NewsArticlesModel] = []
    
    @IBOutlet weak var sortByDateView: UIView!
    @IBOutlet weak var sortByTitleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUi()
    }
    
    @IBAction func didTapSortByDateActionButton(_ sender: Any) {
    
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        viewController.news = news.sorted(by: { $0.publishedAt ?? "" < $1.publishedAt ?? "" })
        navigationController?.pushViewController(viewController, animated: true)
    }
    
     @IBAction func didTapSortByTitleActionButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        viewController.news = news.sorted(by: { $0.title ?? "" < $1.title ?? ""})
        navigationController?.pushViewController(viewController, animated: true)
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
