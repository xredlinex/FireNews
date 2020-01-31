//
//  NewsListViewController+Extension.swift
//  FireNews
//
//  Created by alexey sorochan on 31.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

//  MARK: - TABLE VIEW DELEGATE -
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

//  MARK: - SHOW MORE BUTTON -
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
