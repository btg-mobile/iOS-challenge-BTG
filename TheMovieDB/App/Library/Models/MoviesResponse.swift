//
//  MoviesResponse.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
