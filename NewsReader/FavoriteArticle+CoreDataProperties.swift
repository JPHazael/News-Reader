//
//  FavoriteArticle+CoreDataProperties.swift
//  NewsReader
//
//  Created by admin on 2/27/17.
//  Copyright © 2017 JPDaines. All rights reserved.
//

import Foundation
import CoreData


extension FavoriteArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticle> {
        return NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle");
    }

    @NSManaged public var headline: String?
    @NSManaged public var desc: String?
    @NSManaged public var author: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var articleURL: String?

}
