//
//  WebViewController.swift
//  NewsReader
//
//  Created by admin on 2/25/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    
    var articleURL: String?
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.articleURL)
        //self.webView.loadRequest(URLRequest(url:URL(string: "https://www.youtube.com/watch?v=C7gCKUb8LDM")!))
        webView.loadRequest(URLRequest(url: URL(string: articleURL!)!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
