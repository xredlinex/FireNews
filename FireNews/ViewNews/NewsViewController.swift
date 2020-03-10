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
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForActivityIndicator()
        
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

