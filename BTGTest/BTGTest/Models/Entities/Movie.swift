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
    @objc dynamic var posterPath: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var releaseDate: Date = Date()

    // MARK: - Computed Paramethers
    var smallPosterURL: URL? {
        guard !posterPath.isEmpty else { return nil }
        let urlPath = URLPath(baseURLType: .movieDBImage, path: posterPath)
        return URL(string: urlPath.imagePath(forSize: .small))
    }

    var largePosterURL: URL? {
        guard !posterPath.isEmpty else { return nil }
        let urlPath = URLPath(baseURLType: .movieDBImage, path: posterPath)
        return URL(string: urlPath.imagePath(forSize: .large))
    }

    var backdropURL: URL? {
        guard !backdropPath.isEmpty else { return nil }
        let urlPath = URLPath(baseURLType: .movieDBImage, path: backdropPath)
        return URL(string: urlPath.imagePath(forSize: .backdrop))
    }

    var releaseYear: String {
        return "\(Calendar.current.component(.year, from: releaseDate))"
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
        posterPath       <- map["poster_path"]
        backdropPath     <- map["backdrop_path"]
        releaseDate      <- (map["release_date"], DateTransform())
    }

}
