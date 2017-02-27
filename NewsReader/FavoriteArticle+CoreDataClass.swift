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
    
    
    convenience init(articleURL: String, context: NSManagedObjectContext) {
        
        //Core Data
        if let entity = NSEntityDescription.entity(forEntityName: "FavoriteArticle", in: context){
            self.init(entity: entity, insertInto: context)
        } else {
            fatalError("Unable to find entity name!")
        }
    }
    
    

}
