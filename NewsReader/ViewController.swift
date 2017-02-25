//
//  ViewController.swift
//  NewsReader
//
//  Created by admin on 2/23/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import UIKit
import HMSegmentedControl

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var espnData = [String: AnyObject]()
    var articlesArray:[Article]? = []
    var segmentedControl: HMSegmentedControl!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupSegmentedControl()
        
        NetworkingClient.sharedInstance.fetchArticles(url: NetworkingClient.sharedInstance.espnURL, completion:{ (data) in
        
            self.articlesArray = data
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        })
    }
    
    
    func setupSegmentedControl(){
        
        
        segmentedControl = HMSegmentedControl(frame: CGRect(x: 0, y: 70, width: self.view.frame.size.width, height: 60))
        segmentedControl.sectionTitles = ["ESPN", "Posts"]
        
        segmentedControl.backgroundColor = .white
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectionIndicatorLocation = .up
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.selectionIndicatorColor = UIColor.lightGray
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.titleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSFontAttributeName : UIFont.systemFont(ofSize: 17)
        ]
        
        segmentedControl.selectedTitleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 0.05439098924, green: 0.1344551742, blue: 0.1884709597, alpha: 1),
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)
        ]
        
        self.view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(ViewController.segementedControlAction), for: UIControlEvents.valueChanged)
        
        
    }
    
    func segementedControlAction(){
        if segmentedControl?.selectedSegmentIndex == 0{
            self.tableView.rowHeight = UITableViewAutomaticDimension
        } else{
            self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
            tableView.tableHeaderView?.isHidden = true
        }
    }
   
    // MARK: TABLE VIEW DELEGATE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesArray?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
        
        cell.authorLabel.text = articlesArray?[indexPath.row].author
        cell.titleLabel.text  = articlesArray?[indexPath.row].headline
        cell.descriptionLabel.text = articlesArray?[indexPath.row].desc
        if articlesArray?[indexPath.row].imageURL != nil {
        cell.previewImageView.imageFromUrl(urlString: (articlesArray?[indexPath.row].imageURL!)!)
        }
        return cell
        } else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
