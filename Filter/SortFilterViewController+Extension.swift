//
//  SortFilterViewController+Extension.swift
//  FireNews
//
//  Created by alexey sorochan on 01.02.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

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
