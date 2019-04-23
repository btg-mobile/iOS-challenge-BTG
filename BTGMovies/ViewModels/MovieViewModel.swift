//
//  MovieViewModel.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    let movie: Movie
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var releaseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let dateString = formatter.string(from: movie.releaseDate)
        return dateString
    }
    
    var posterPath: String {
        return movie.posterPath
    }
    
    var backdropPath: String {
        return movie.backdropPath
    }
    
    var overview: String {
        return movie.overview
    }
    
    var voteAverage: String {
        return String(movie.voteAverage)
    }
    
    var isFavorite: Bool {
        return MoviePersistenceManager.shared.movie(id: movie.id) != nil
    }
}

extension MovieViewModel: Equatable {
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.movie.id == rhs.movie.id
    }
}

// MARK: - CoreData

extension MovieViewModel {
    func saveMovie() {
        MoviePersistenceManager.shared.createMovie(movie)
    }
    
    func removeMovie() {
        MoviePersistenceManager.shared.deleteMovie(id: movie.id)
    }
}
