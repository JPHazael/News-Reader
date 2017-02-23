//
//  Networking Client.swift
//  NewsReader
//
//  Created by admin on 2/23/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingClient{
    
    static let sharedInstance = NetworkingClient()
    
    //var data:[[String: AnyObject]] = [[String: AnyObject]]()
    
    let key = "0201d022142c4483b285a711a61fd490"
    
    let espnURL:URL = URL(string: "https://newsapi.org/v1/articles?source=espn&sortBy=top&apiKey=0201d022142c4483b285a711a61fd490")!
    
    
    func fetchArticles(){
        
        var data:[String: AnyObject] = [String: AnyObject]()
        
        Alamofire.request(espnURL).responseJSON { (response) in
            switch response.result{
            case .success:
                data = response.result.value as! [String: AnyObject]
                print(data)
            case .failure(let error):
                print(error)

            
            }
        }
        
    }
    
    
    
    
}
