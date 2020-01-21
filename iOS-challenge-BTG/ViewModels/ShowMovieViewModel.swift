//
//  ShowMovieViewModel.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation

class ShowMovieViewModel {

    var movie = Movie()
    let movieService = MovieService()
}

// MARK: - Requests
extension ShowMovieViewModel {

    func fetchMovie(completion: @escaping (Movie) -> ()) {
        guard let id = self.movie.id else { return }
        self.movieService.fetchMovie(with: id) {
            (movie, serviceError) in

            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let movie = movie {
                self.movie.genres = movie.genres
                completion(self.movie)
            }
        }
    }
}
