//
//  NewsListViewController.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var news: [NewsArticlesModel] = []
    var parameters: [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func didTapGoBackActionButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchNewsViewController") as! SearchNewsViewController
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func didTapSortActionButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SortFilterViewController") as! SortFilterViewController
        viewController.news = news
        viewController.parameters = parameters
        navigationController?.pushViewController(viewController, animated: false)
    }
}

