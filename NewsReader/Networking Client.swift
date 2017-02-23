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
    //var articlesArray:[Article]? = []
    
    let key = "0201d022142c4483b285a711a61fd490"
    
    let espnURL:URL = URL(string: "https://newsapi.org/v1/articles?source=espn&sortBy=top&apiKey=0201d022142c4483b285a711a61fd490")!
    
    
    func fetchArticles(url: URL, completion: @escaping([Article]) -> Void){
        
        var data:[String: AnyObject] = [String: AnyObject]()
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success:
                data = response.result.value as! [String: AnyObject]
                
                
                
                if let articlesFromData = data["articles"] as? [[String: AnyObject]]{
                   // print(articlesFromData)
                    var articlesArray:[Article]? = []

                    for articleFromData in articlesFromData {
                        let article = Article()
                        
                    if let headline = articleFromData["title"] as? String, let author = articleFromData["author"] as? String, let desc = articleFromData["description"] as? String, let articleURL = articleFromData["URL"] as? String, let imageURL = articleFromData["urltoimage"] as? String{
                        
                        
                            article.author = author
                            article.headline = headline
                            article.desc = desc
                            article.URL = articleURL
                            article.imageURL = imageURL
                        
                        }
                    articlesArray?.append(article)
                   // print(articlesArray)
                    completion(articlesArray!)
                    }
                    
                }
            case .failure(let error):
                print(error)

            
            }
        }
        
    }
    
    
    
    
}
