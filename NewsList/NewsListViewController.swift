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
    var parameters: [String : String] = [:]
    
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
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.updateNewsCell(news[indexPath.row])
        cell.delegate = self
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension NewsListViewController: NewsTableViewCellDelegate {
    func didTapShowDescrioption(index: Int) {
        if news[index].showDescript == false {
            news[index].showDescript = true
        } else {
            news[index].showDescript = false
        }
        tableView.reloadData()
    }
}
