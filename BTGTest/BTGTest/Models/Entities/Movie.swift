//
//  Movie.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

// MARK: - Device
class Movie: Object, Mappable {

    // MARK: - Stored Paramethers
    @objc dynamic var id: Int = -1
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var posterPath: String = ""

    // MARK: - Computed Paramethers
    var smallPosterURL: URL? {
        let urlPath = URLPath(baseURLType: .movieDBImage, path: posterPath)
        return URL(string: urlPath.imagePath(forSize: .small))
    }

    // MARK: - Primary Key
    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: - Object Copy
    var clone: Movie {
        return Movie(value: self)
    }

    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        id               <- map["id"]
        title            <- map["title"]
        overview         <- map["overview"]
        releaseDate      <- map["release_date"]
        originalTitle    <- map["original_title"]
        originalLanguage <- map["original_language"]
        posterPath       <- map["poster_path"]
    }

}
