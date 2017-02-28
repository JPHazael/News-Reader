//
//  favoritesViewController.swift
//  NewsReader
//
//  Created by admin on 2/27/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var articleContext: NSManagedObjectContext {
        return delegate.stack.context
    }

    var favorite: FavoriteArticle!
    
    lazy var fetchedResultsController: NSFetchedResultsController<FavoriteArticle>? = {
        let fetchRequest = NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle")
        //fetchRequest.predicate = NSPredicate(format: "FavoriteArticle == %@", self.favorite)
        fetchRequest.sortDescriptors = []
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: self.articleContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }()
 
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
        try fetchedResultsController?.performFetch()
        }catch{
            print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let article = fetchedResultsController!.object(at: indexPath) as! FavoriteArticle
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
        
        cell.authorLabel.text = article.author
        cell.descriptionLabel.text = article.desc
        cell.titleLabel.text = article.headline

            return cell
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}





