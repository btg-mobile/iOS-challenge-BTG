//
//  Favourite+CoreDataClass.swift
//  
//
//  Created by pc on 14/10/19.
//
//

import Foundation
import CoreData

@objc(Favourite)
public class Favourite: NSManagedObject {
    var movie : Movie {
        get {
            return Movie(posterPath: self.posterPath, movieId: Int(truncatingIfNeeded: self.movieId), originalTitle: self.originalTitle, genreIds: self.genreIds?.map({
                $0.intValue
            }), voteAverage: self.voteAverage, overview: self.overview, releaseDate: self.releaseDate)
        }
        set {
            self.posterPath = newValue.posterPath
            self.movieId = Int64(newValue.movieId ?? 0)
            self.originalTitle = newValue.originalTitle
            if let list = newValue.genreIds {
                self.genreIds = list.map({
                    NSNumber(value:$0)
                })
            }
            self.voteAverage = newValue.voteAverage ?? 0.0
            self.overview = newValue.overview
            self.releaseDate = newValue.releaseDate
            
        }
    }
}
