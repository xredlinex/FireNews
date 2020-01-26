//
//  NewsTableViewCell.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

protocol NewsTableViewCellDelegate {
    func didTapShowDescrioption(index: Int)
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleTextLabel: UILabel!
    @IBOutlet weak var newsDescriptionTextLabel: UILabel!
    @IBOutlet weak var newsPublishAtTextLabel: UILabel!
    
    @IBOutlet weak var showDescriotionHeightContstraint: NSLayoutConstraint!
    
    
    var delegate: NewsTableViewCellDelegate?
    var showDescription = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    @IBAction func didTapShowDescription(_ sender: Any) {
  
        showDescript()
        
        
        
        
    }
    
    
    func updateNewsCell(_ news: NewsArticlesModel) {
        
        newsTitleTextLabel.text = news.title ?? "-"
        
        newsDescriptionTextLabel.text = news.description ?? "-"
        
        newsPublishAtTextLabel.text = news.publishedAt ?? "-"
    }
    
    
    func showDescript() {
        delegate?.didTapShowDescrioption(index: tag)
    }
    
}
