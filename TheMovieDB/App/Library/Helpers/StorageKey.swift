//
//  StorageKey.swift
//  TheMovieDB
//
//  Created by Usuario on 30/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation

enum StorageKey: String {
    case movies
    case genres
}

extension StorageKey {
    var key: String {
        switch self {
        case .movies:
            return "movies"
        case .genres:
            return "genres"
        }
    }
}
