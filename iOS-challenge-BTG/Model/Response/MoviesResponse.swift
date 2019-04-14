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
    let genres : [Genre]?
    let id : Int
    let overview : String
    let posterPath : String
    let releaseDate : String
    let title : String
    let voteAverage : Float
    var isFavorite : Bool?
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
        case id = "id"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case voteAverage = "vote_average"
    }
}

struct Genre : Codable {
    let id : Int
    let name : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
