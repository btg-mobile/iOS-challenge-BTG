//
//  Movie.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

struct MoviesResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: Date
    let posterPath: String
    let backdropPath: String
}

extension Movie {
    init(fromPersistence movie: MoviePersistence) {
        self.init(id: Int(movie.id), title: movie.title ?? "", overview: movie.overview ?? "", releaseDate: movie.releaseYear ?? Date(), posterPath: movie.posterPath ?? "", backdropPath: movie.backdropPath ?? "")
    }
}

extension MoviePersistence {
    func fromObject(_ movie: Movie) {
        self.id = Int64(movie.id)
        self.title = movie.title
        self.overview = movie.overview
        self.releaseYear = movie.releaseDate
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
    }
}
