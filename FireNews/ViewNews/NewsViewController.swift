//
//  NewsViewController.swift
//  FireNews
//
//  Created by alexey sorochan on 25.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlRecieve = URL(string: url) {
            let urlRequest = URLRequest(url: urlRecieve)
            webView.load(urlRequest)
        }
        
        webView.navigationDelegate = self
    }
    
    @IBAction func didTapGoBackButton(_ sender: Any) {
        navigationController?.popViewController(animated:  false)
    }
}

extension NewsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let activityIndicator = self.view.subviews.filter({ $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
