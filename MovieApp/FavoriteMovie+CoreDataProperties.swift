//
//  FavoriteMovie+CoreDataProperties.swift
//  MovieApp
//
//  Created by Lucas Moraes on 15/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var date: String?
    @NSManaged public var descrip: String?
    @NSManaged public var image: NSObject?
    @NSManaged public var rate: Double
    @NSManaged public var title: String?

}
