//
//  NewsTableViewCell.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import Kingfisher

protocol NewsTableViewCellDelegate {
    func didTapShowDescrioption(index: Int)

}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var viewForImageView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleTextLabel: UILabel!
    @IBOutlet weak var newsDescriptionTextLabel: UILabel!
    @IBOutlet weak var newsPublishAtTextLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var showDescriotionHeightContstraint: NSLayoutConstraint!
    
    var delegate: NewsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func didTapShowDescription(_ sender: Any) {
        delegate?.didTapShowDescrioption(index: tag)
    }
    
    func updateNewsCell(_ news: NewsArticlesModel) {
        
//        MARK: - show hide button -
        if news.showDescript == true {
            showDescriotionHeightContstraint.priority = UILayoutPriority(rawValue: 800)
            newsDescriptionTextLabel.numberOfLines = 0
            showMoreButton.setTitle("hide", for: .normal)
        } else {
            showDescriotionHeightContstraint.priority = UILayoutPriority(rawValue: 600)
            newsDescriptionTextLabel.numberOfLines = 1
            showMoreButton.setTitle("show more", for: .normal)
        }
        
//        MARK: - dowload image from url kingsfisher -
        if let url = news.urlToImage {
          let imgUrl = URL(string: url)
            newsImageView.kf.setImage(with: imgUrl)
        } else {
            newsImageView.image = UIImage(named: "noImage")
        }

        newsTitleTextLabel.text = news.title ?? "-"
        newsDescriptionTextLabel.text = news.description ?? "-"
        newsPublishAtTextLabel.text = convertDate(news.publishedAt ?? "-")

//       MARK: - visual ui part -
        viewForImageView.clipsToBounds = true
        viewForImageView.layer.cornerRadius = 8
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 8
    }
}

//      MARK: - date convert
extension NewsTableViewCell {
    func convertDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        let format = DateFormatter()
        format.dateFormat = "dd / MMM / yyyy hh:mm a"
        if let date = dateFormatter.date(from: dateString) {
            return format.string(from: date)
        } else {
            return "-"
        }
    }
}
