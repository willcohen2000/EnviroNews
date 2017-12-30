//
//  ArticleController.swift
//  EnvironNews
//
//  Created by Will Cohen on 12/30/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import WebKit

class ArticleController: UIViewController {

    @IBOutlet weak var articleWebView: WKWebView!
    @IBOutlet weak var articleProgressBar: UIProgressView!
    
    var articleURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        articleWebView.navigationDelegate = self;
        articleWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
        let url = URL(string: articleURL);
        let request = URLRequest(url: url!);
        articleWebView.load(request);
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    deinit {
        articleWebView.removeObserver(self, forKeyPath: "estimatedProgress");
    }

}

extension ArticleController: WKNavigationDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") { // listen to changes and updated view
            articleProgressBar.isHidden = articleWebView.estimatedProgress == 1;
            articleProgressBar.setProgress(Float(articleWebView.estimatedProgress), animated: false);
        }
    }
    
}



