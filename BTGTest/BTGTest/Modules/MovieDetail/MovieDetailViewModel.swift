//
//  MovieDetailViewModel.swift
//  BTGTest
//
//  Created by Mario de Castro on 08/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

class MovieDetailViewModel {

    private weak var view: MovieDetailViewOutput!

    private let movie: Movie

    init(view: MovieDetailViewOutput, movie: Movie) {
        self.view = view
        self.movie = movie
    }

    private func getDetails() {
        view.setDetailsLoading()

        MovieDetailEndpoint(movieID: movie.id).makeRequest { (response, error) in
            guard error == nil, let response = response, response.genres.count > 0 else {
                self.view.fillGenres("NO_GENRE_ERROR".localized)
                return
            }

            var genres = ""
            for genre in response.genres {
                if !genres.isEmpty { genres += " - " }
                genres += genre.name
            }

            self.view.fillGenres(genres)
        }
    }
}

extension MovieDetailViewModel: MovieDetailViewInput {
    func loadDetails() {
        view.fill(with: movie)
        getDetails()
    }
}
