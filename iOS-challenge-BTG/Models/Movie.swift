//
//  Movie.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 17/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int? = 0
    var posterPath: String? = ""
    var releaseDate: Date? = Date()
    var title: String? = ""
    var overview: String? = ""
    var genres: [Genre]?
    var voteAverage: Decimal? = 0
    var smallPosterPath: String {
        return "https://image.tmdb.org/t/p/w300\(posterPath ?? "")"
    }
    var largePosterPath: String {
        return "https://image.tmdb.org/t/p/original\(posterPath ?? "")"
    }
    var releaseYear: String {
        return "\(Calendar.current.component(.year, from: releaseDate ?? Date()))"
    }
    var formatedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: releaseDate ?? Date())
    }

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case overview
        case genres
        case voteAverage = "vote_average"
    }
}

struct MovieViewModel: Codable {
    var page: Int? = 1
    var totalPages: Int? = 1
    var search: String?
    var movies: [Movie]? = []

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case search
        case movies = "results"
    }
}
