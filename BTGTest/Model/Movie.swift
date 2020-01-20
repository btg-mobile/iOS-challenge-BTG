//
//  Movie.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 11/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import Foundation

class Movie: Codable {
    
    init() {}
    
    var id: Int?
    var title: String?
    var voteAverage: Double?
    var voteCount: Int?
    var genres: [Genre]?
    var genreIds: [Int]?
    var backdropPath: String?
    var posterPath: String?
    var overview: String?
    var data: Data?
    var dataBackdrop: Data?
    var date: String?
    var isFavorited = false
    
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case title = "title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview = "overview"
        case date = "release_date"
    }
}

struct Genre: Codable {
    var id: Int?
    var name: String?
    
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
    }
}

struct Genres: Codable {
    var genres: [Genre]?
}

struct Response: Codable{
    var page: Int?
    var results: [Movie]?
    var totalResults: Int?
    var totalPages: Int?
    
    private enum CodingKeys: String, CodingKey{
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
