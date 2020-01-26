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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        debugPrint(index)
        
        

    }
    
    
}
