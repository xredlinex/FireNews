//
//  ClassExtension.swift
//  FireNews
//
//  Created by alexey sorochan on 30.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertErrorMessage(_ message: String) {
        view.isUserInteractionEnabled = true
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in }
        alertController.addAction(alertAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func transferControll(_ news: [NewsArticlesModel], parameters: [String : Any]) {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.isNavigationBarHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        viewController.news = news
        viewController.parameters = parameters
        debugPrint("trans")
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        navigationController.pushViewController(viewController, animated: false)
    }
}
