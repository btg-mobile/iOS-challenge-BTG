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
    private var moviesList: [Movie] = []
    private let debouncer = Debouncer()

    private var currentPage: Int = 0
    private var totalPages: Int = 1000000

    private var searchText = ""

    // MARK: - Life Cycle
    init(view: MovieListViewOutput) {
        self.view = view
    }

    // MARK: - Private Methods
    private func updateMovieList(_ movies: [Movie]) {
        moviesList.append(contentsOf: movies)
        view.reloadMovieTableView(resetScroll: currentPage == 1)
    }

    // MARK: - Networking
    private func fetchMovies(page: Int = 1) {
        if page == 1 {
            moviesList = []
            view.startFullScreenLoading()
        }

        PopularMoviesEndpoint(page: page).makeRequest { (response, error) in
            self.view.stopFullScreenLoading()

            guard error == nil, let response = response else {
                if page == 1 {
                    self.view.showErrorMessage("FAILED_MOVIE_LIST_MESSAGE".localized, tryAgain: true)
                }
                return
            }

            self.currentPage = response.page
            self.totalPages = response.totalPages
            self.updateMovieList(response.movies)
        }
    }

    private func searchMovie(_ searchText: String, page: Int = 1) {
        guard !searchText.isEmpty else {
            fetchMovieList()
            return
        }

        if page == 1 {
            moviesList = []
            view.startFullScreenLoading()
        }

        SearchMovieEndpoint(searchText: searchText, page: page).makeRequest { (response, error) in
            self.view.stopFullScreenLoading()
            
            guard error == nil, let response = response else {
                if page == 1 {
                    self.view.showErrorMessage("FAILED_MOVIE_LIST_MESSAGE".localized, tryAgain: true)
                }
                return
            }

            guard response.movies.count > 0 else {
                let errorMessage = "NO_MOVIE_FOUND".localized.replacingOccurrences(of: "%@", with: searchText)
                self.view.showErrorMessage(errorMessage, tryAgain: false)
                return
            }

            self.currentPage = response.page
            self.totalPages = response.totalPages
            self.updateMovieList(response.movies)
        }
    }
}

// MARK: - MovieListViewInput
extension MovieListViewModel: MovieListViewInput {
    func fetchMovieList() {
        fetchMovies()
    }

    func didChangeSearchText(_ text: String) {
        searchText = text
        debouncer.debounce(delay: 0.75) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.searchMovie(text)
        }
    }

    func resetSearch() {
        searchText = ""
    }

    func retrySearch() {
        guard !searchText.isEmpty else {
            fetchMovies()
            return
        }

        searchMovie(searchText)
    }

    func movieCount() -> Int {
        return moviesList.count
    }

    func movie(at position: Int) -> Movie {
        return moviesList[position]
    }

    func isMovieFavorited(movie: Movie) -> Bool {
        return FavoritesManager.isMovieFavorited(movie)
    }

    func toggleFavorite(at position: Int) {
        let movie = moviesList[position]
        if FavoritesManager.isMovieFavorited(movie) {
            FavoritesManager.deleteFavorite(movie)
        } else {
            FavoritesManager.addFavorite(movie)
        }
    }

    func willDisplayCell(at position: Int) {
        if position == moviesList.count-1, currentPage < totalPages {
            let page = currentPage+1

            if !searchText.isEmpty {
                searchMovie(searchText, page: page)
            } else {
                fetchMovies(page: page)
            }
        }
    }
}
