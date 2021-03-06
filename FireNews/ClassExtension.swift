//
//  ClassExtension.swift
//  FireNews
//
//  Created by alexey sorochan on 30.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}

extension UIViewController {
    
    func showAlertErrorMessage(_ message: String) {
        let customKeyWindow: UIWindow? = UIApplication.shared.keyWindow
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in}
        customKeyWindow?.viewWithTag(666)?.removeFromSuperview()
        alertController.addAction(alertAction)
        customKeyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func transferControll(_ news: [NewsArticlesModel], parameters: [String : Any]) {
        
        let myKeyWindow: UIWindow? = UIApplication.shared.keyWindow
        let navigationController = UINavigationController(rootViewController: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        navigationController.isNavigationBarHidden = true
        myKeyWindow?.rootViewController = navigationController
        viewController.news = news
        viewController.parameters = parameters
        navigationController.pushViewController(viewController, animated: false)
    }
}




