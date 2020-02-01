//
//  MovieDataSource+CoreDataClass.swift
//  TheMovieDB
//
//  Created by Usuario on 31/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MovieDataSource)
public class MovieDataSource: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDataSource> {
        return NSFetchRequest<MovieDataSource>(entityName: "MovieDataSource")
    }
    @NSManaged public var genreIds: String?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: NSDecimalNumber?
}
