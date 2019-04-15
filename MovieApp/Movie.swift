//
//  Movie.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import Foundation

struct Result: Codable {
    var results: [Movie]
}

struct Movie: Codable {
    var id: Int
    var title: String
    var description: String
    var rate: Double
    var date: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case rate = "vote_average"
        case date = "release_date"
        case imageUrl = "poster_path"
    }
}
