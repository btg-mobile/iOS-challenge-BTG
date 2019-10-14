//
//  Movie.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit
import CoreData

struct Movie: Decodable {
    let posterPath: String?
    let movieId: Int?
    let originalTitle: String?
    let genreIds: [Int]?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case movieId = "id"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
        
    }
    
}

