//
//  FavoriteGenre.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 01/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import RealmSwift

class IntGenreID: Object {
    @objc dynamic var id : Int = 0
    
    var parentCategory = LinkingObjects(fromType: FavoriteMovie.self, property: "items")
}
