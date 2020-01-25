//
//  NewsTableViewCell.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsTitleTextLabel: UILabel!
    
    @IBOutlet weak var newsDescriptionTextLabel: UILabel!

    @IBOutlet weak var newsPublishAtTextLabel: UILabel!
    



    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func updateNewsCell(_ news: NewsArticlesModel) {
        
        newsTitleTextLabel.text = news.title ?? "-"
        
        newsDescriptionTextLabel.text = news.description ?? "-"
        
        newsPublishAtTextLabel.text = news.publishAt ?? "-"
    }
    
}
