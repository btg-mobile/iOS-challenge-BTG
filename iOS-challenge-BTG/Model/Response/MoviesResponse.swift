//
//  MoviesResponse.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

struct MoviesResponse : Codable {
    let page : Int
    let results : [MoviesResult]
    let totalPages : Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
    }
}

struct MoviesResult : Codable {
    let id : Int
    let posterPath : String
    let releaseDate : String
    let title : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
    }
}
