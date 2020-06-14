//
//  Favorite.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 30/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteMovie : Object {

    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var posterPath: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    let items = List<IntGenreID>()
    @objc dynamic let genreIDS : Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var overview : String = ""
    @objc dynamic var releaseDate: String = ""

}
