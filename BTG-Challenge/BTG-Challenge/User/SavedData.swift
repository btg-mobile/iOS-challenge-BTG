//
//  SavedData.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/23/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import Foundation


class UserData {
    static let sharedInstance = UserData()
    private var favorites : [Results] = []
    func addFavorite(r : Results) {
        if !favorites.contains(where: {$0.id == r.id}) {
            favorites.append(r)
        }
    }
    func removeFavorite(r : Results){
        var i = 0
        var index : Int? = nil
        for fav in favorites {
            if fav.id == r.id {
                index = i
                break
            }
            i += 1
        }
        guard index != nil else {
            return
        }
        favorites.remove(at: index!)
    }
    func isFavorite(r: Results) -> Bool{
        return favorites.contains(where: {$0.id == r.id})
    }
    func getFavorites() -> [Results] {
        return favorites
    }
    private init() {
        
    }
}
