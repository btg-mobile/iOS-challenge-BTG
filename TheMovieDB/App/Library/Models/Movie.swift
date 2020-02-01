//
//  Movie.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: Int64?
    var title: String?
    var releaseDate: String?
    var overview: String?
    var genreIds: [Int]?
    var voteAverage: Decimal?
    var posterPath: String?
    
    init(id: Int64?, title: String?, releaseDate: String?, overview: String?, genreIds: [Int]?, voteAverage: Decimal?, posterPath: String?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.genreIds = genreIds
        self.voteAverage = voteAverage
        self.posterPath = posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case overview = "overview"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
