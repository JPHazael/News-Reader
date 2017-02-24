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
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        })
    }
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesArray?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
        
        cell.authorLabel.text = articlesArray?[indexPath.row].author
        cell.titleLabel.text  = articlesArray?[indexPath.row].headline
        cell.descriptionLabel.text = articlesArray?[indexPath.row].desc
        if articlesArray?[indexPath.row].imageURL != nil {
        cell.previewImageView.imageFromUrl(urlString: (articlesArray?[indexPath.row].imageURL!)!)
        }
        return cell
    }
}

extension UIImageView{
    
        func imageFromUrl(urlString: String) {
            
            let urlRequest = URLRequest(url: URL(string: urlString)!)
            let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                self.image = UIImage(data: data!)
                }
            }
      task.resume()
    }

}
