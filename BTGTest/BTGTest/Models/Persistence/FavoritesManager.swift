//
//  FavoritesManager.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 09/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import RealmSwift

class FavoritesManager {

    static private let realm = try! Realm()

    static private var favorites: Results<Movie> {
        return realm.objects(Movie.self)
    }

    static func favoriteList() -> [Movie] {
        var favoriteList: [Movie] = []
        for favorite in favorites {
            favoriteList.append(favorite.clone)
        }
        return favoriteList
    }

    static func isMovieFavorited(_ movie: Movie) -> Bool {
        if let _ = getRealmObject(withPrimaryKey: movie.id) {
            return true
        }
        return false
    }

    static func addFavorite(_ movie: Movie) {
        addToRealm(movie.clone)
    }

    static func deleteFavorite(_ movie: Movie) {
        if let persistedObject = getRealmObject(withPrimaryKey: movie.id) {
            deleteFromRealm(persistedObject)
        }
    }

    static private func getRealmObject(withPrimaryKey key: Int) -> Movie? {
        return realm.object(ofType: Movie.self, forPrimaryKey: key)
    }

    static private func addToRealm(_ movie: Movie) {
        try! realm.write {
            realm.add(movie, update: .all)
        }
    }

    static private func deleteFromRealm(_ movie: Movie) {
        try! realm.write {
            realm.delete(movie)
        }
    }

}
