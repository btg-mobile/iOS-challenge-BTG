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
    private var favorited: Bool = false

    init(view: MovieDetailViewOutput, movie: Movie) {
        self.view = view
        self.movie = movie
    }

    private func checkFavorite() {
        favorited = FavoritesManager.isMovieFavorited(movie)
        if favorited {
            view.updateFavoriteButton(title: "UNFAVORITE_BUTTON".localized.uppercased(), highlighted: false)
        } else {
            view.updateFavoriteButton(title: "FAVORITE_BUTTON".localized.uppercased(), highlighted: true)
        }
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

            self.view.fillRating("\(response.rating)")
            self.view.fillGenres(genres)
        }
    }
}

extension MovieDetailViewModel: MovieDetailViewInput {
    func loadDetails() {
        view.fillTitle(movie.title)
        view.fillYear(movie.releaseYear)

        let overview = movie.overview.isEmpty ? "NO_OVERVIEW_ERROR".localized : movie.overview
        view.fillOverview(overview)

        view.setPosterImage(with: movie.largePosterURL)
        view.setBackdropImageURL(with: movie.backdropURL)

        checkFavorite()
        getDetails()
    }

    func toggleFavorite() {
        if favorited {
            FavoritesManager.deleteFavorite(movie)
        } else {
            FavoritesManager.addFavorite(movie)
        }
        checkFavorite()
    }
}
