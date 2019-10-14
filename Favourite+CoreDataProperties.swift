//
//  Favourite+CoreDataProperties.swift
//  
//
//  Created by pc on 14/10/19.
//
//

import Foundation
import CoreData


extension Favourite {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }
    
    @NSManaged public var genreIds: NSObject?
    @NSManaged public var movieId: Int64
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: Double
    
    
}
