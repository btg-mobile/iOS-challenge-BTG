//
//  Genre.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 30/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let genres: [GenreElement]
}

// MARK: - GenreElement
struct GenreElement: Codable {
    let id: Int
    let name: String
}
