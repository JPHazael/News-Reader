//
//  ViewController.swift
//  NewsReader
//
//  Created by admin on 2/23/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import UIKit
import HMSegmentedControl
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var ESPNarticlesArray:[Article]? = []
    var TSarticlesArray:[Article]? = []
    var segmentedControl: HMSegmentedControl!

    @IBOutlet weak var tableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var articleContext: NSManagedObjectContext {
        return delegate.stack.context
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
        self.setupSegmentedControl()
        
        NetworkingClient.sharedInstance.fetchArticles(url: NetworkingClient.sharedInstance.espnURL, completion:{ (data) in
        
            self.ESPNarticlesArray = data
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        })
        
        
        NetworkingClient.sharedInstance.fetchArticles(url: NetworkingClient.sharedInstance.tsURL) { (data) in
            self.TSarticlesArray = data
            
        }
        
        
    }
    
    
    func setupSegmentedControl(){
        
        
        segmentedControl = HMSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 70))
        segmentedControl.sectionTitles = ["ESPN", "TalkSport"]

        
        segmentedControl.backgroundColor = .black
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectionIndicatorLocation = .up
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.selectionIndicatorColor = UIColor.lightGray
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.titleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont.systemFont(ofSize: 17)
        ]
        
        segmentedControl.selectedTitleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)
        ]
        
        self.view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(ViewController.segementedControlAction), for: UIControlEvents.valueChanged)
        
        
    }
    
    func segementedControlAction(){
        if segmentedControl?.selectedSegmentIndex == 0{
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        } else{
            self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        }
    }
   
    // MARK: TABLE VIEW DELEGATE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0{
        return self.ESPNarticlesArray?.count ?? 0
        } else{
            return self.TSarticlesArray?.count ?? 0
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
            

        
        cell.authorLabel.text = ESPNarticlesArray?[indexPath.row].author
        cell.titleLabel.text  = ESPNarticlesArray?[indexPath.row].headline
        cell.descriptionLabel.text = ESPNarticlesArray?[indexPath.row].desc
        if ESPNarticlesArray?[indexPath.row].imageURL != nil {
        cell.previewImageView.imageFromUrl(urlString: (ESPNarticlesArray?[indexPath.row].imageURL!)!)
        }
        return cell
        } else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
            
            cell.authorLabel.text = TSarticlesArray?[indexPath.row].author
            cell.titleLabel.text  = TSarticlesArray?[indexPath.row].headline
            cell.descriptionLabel.text = TSarticlesArray?[indexPath.row].desc
            if TSarticlesArray?[indexPath.row].imageURL != nil {
                cell.previewImageView.imageFromUrl(urlString: (TSarticlesArray?[indexPath.row].imageURL!)!)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController

            vc.articleURL = self.ESPNarticlesArray?[indexPath.row].URL

        if segmentedControl.selectedSegmentIndex == 1{
         if TSarticlesArray?[indexPath.row].URL != nil {
            
            vc.articleURL = self.TSarticlesArray?[indexPath.row].URL
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let saveAction =  UITableViewRowAction(style: .default, title: "Tap to add to Favorites") { (action, indexPath) in
            print("Article added to favorites!")
             if self.segmentedControl.selectedSegmentIndex == 0{
            _ = FavoriteArticle(articleURL: (self.ESPNarticlesArray?[indexPath.row].URL)!, author: (self.ESPNarticlesArray?[indexPath.row].author), desc: (self.ESPNarticlesArray?[indexPath.row].desc)!, imageURL: (self.ESPNarticlesArray?[indexPath.row].imageURL)!, headline: (self.ESPNarticlesArray?[indexPath.row].headline)!, context: self.articleContext)
             } else {
                _ = FavoriteArticle(articleURL: (self.TSarticlesArray?[indexPath.row].URL)!, author: (self.TSarticlesArray?[indexPath.row].author), desc: (self.TSarticlesArray?[indexPath.row].desc)!, imageURL: (self.TSarticlesArray?[indexPath.row].imageURL)!, headline: (self.TSarticlesArray?[indexPath.row].headline)!, context: self.articleContext)
            }
            do{
                try self.delegate.stack.saveContext()
                print("Saved Article!")
            }catch{
                print("There was an error while saving context")
            }
        }
        saveAction.backgroundColor = #colorLiteral(red: 0.42916254, green: 0.6046701975, blue: 1, alpha: 1)
        return[saveAction]
    }
    
}


extension String{
    func fixESPNTag()-> String{
        var newWord = self
        newWord = newWord.replacingOccurrences(of: "ESPN", with: " ESPN")
        
        return newWord
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
