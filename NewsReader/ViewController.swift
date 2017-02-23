//
//  ViewController.swift
//  NewsReader
//
//  Created by admin on 2/23/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var espnData = [String: AnyObject]()
    var articlesArray:[Article]? = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkingClient.sharedInstance.fetchArticles(url: NetworkingClient.sharedInstance.espnURL, completion:{ (data) in
        
            self.articlesArray = data
            //print(self.articlesArray)
            self.tableView.reloadData()
        })
    }
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.articlesArray?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell!
        
        cell?.authorLabel.text = articlesArray?[indexPath.row].author
        
        return cell!
    }
    

}

