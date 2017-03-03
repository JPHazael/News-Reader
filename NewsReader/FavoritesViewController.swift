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
        
        let sortDiscriptor = NSSortDescriptor(key: "headline", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: self.articleContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }()
 
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 70.0)
        
        navBar.titleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont.systemFont(ofSize: 20)
        ]
    }
    
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
        if let fc = fetchedResultsController {
            return fc.sections![section].numberOfObjects
        } else {
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let fc = fetchedResultsController {
            return (fc.sections?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let article = fetchedResultsController!.object(at: indexPath) 
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
        
        cell.authorLabel.text = article.author
        cell.descriptionLabel.text = article.desc
        cell.titleLabel.text = article.headline
        
        cell.previewImageView.imageFromUrl(urlString: article.imageURL!)

            return cell
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        
        let article = fetchedResultsController!.object(at: indexPath) 

        
        vc.articleURL = article.articleURL
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
}





