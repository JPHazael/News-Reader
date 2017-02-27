//
//  favoritesViewController.swift
//  NewsReader
//
//  Created by admin on 2/27/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var articleContext: NSManagedObjectContext {
        return delegate.stack.context
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell

            return cell
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}





