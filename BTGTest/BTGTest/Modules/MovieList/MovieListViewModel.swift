//
//  MovieListViewModel.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

// MARK: - MovieListViewModel
class MovieListViewModel {

    // MARK: - View
    private weak var view: MovieListViewOutput!

    // MARK: - Private Parameters
    private var popularMoviesList: [Movie] = []

    // MARK: - Life Cycle
    init(view: MovieListViewOutput) {
        self.view = view
    }

    // MARK: - Private Methods
    func updateMovieList(_ movies: [Movie]) {
        popularMoviesList = movies
        view.reloadMovieTableView()
    }

    // MARK: - Networking
    private func fetchMovies() {
        view.startFullScreenLoading()
        PopularMoviesEndpoint().makeRequest { (response, error) in
            self.view.stopFullScreenLoading()

            if let _ = error {
                self.view.showErrorMessage("FAILED_MOVIE_LIST_MESSAGE".localized)
                return
            }

            guard let response = response else {
                return
            }

            self.updateMovieList(response.movies)
        }
    }
}

// MARK: - MovieListViewInput
extension MovieListViewModel: MovieListViewInput {
    func fetchMovieList() {
        self.fetchMovies()
    }

    func didChangeSearchText(_ text: String) {

    }

    func movieCount() -> Int {
        return popularMoviesList.count
    }

    func movie(at position: Int) -> Movie {
        return popularMoviesList[position]
    }
}
