//
//  FavoriteArticle+CoreDataClass.swift
//  NewsReader
//
//  Created by admin on 2/27/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import Foundation
import CoreData


public class FavoriteArticle: NSManagedObject {
    
//author: String, desc: String, imageURL: String, headline: String
    convenience init(articleURL: String, author: String?, desc: String, imageURL: String, headline: String, context: NSManagedObjectContext) {
        
        //Core Data
        if let entity = NSEntityDescription.entity(forEntityName: "FavoriteArticle", in: context){
            self.init(entity: entity, insertInto: context)
            self.articleURL = articleURL
            self.author = author
            self.desc = desc
            self.imageURL = imageURL
            self.headline = headline
            
        } else {
            fatalError("Unable to find entity name!")
        }
    }

}
