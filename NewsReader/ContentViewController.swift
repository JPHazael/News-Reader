//
//  ContentViewController.swift
//  NewsReader
//
//  Created by admin on 3/3/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    static let sharedInstance = ContentViewController()
    
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    var espnImagesArray = [String]()
    var espnHeadlinesArray = [String]()
    var tsImagesArray = [String]()
    
    var pageIndex = 0
    var imageName: String?
    var headlines: String?

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentImage = imageName{
        
        self.contentImageView.imageFromUrl(urlString: currentImage)
        self.headlineLabel.text = "Welcome to SportsPage."
        
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
