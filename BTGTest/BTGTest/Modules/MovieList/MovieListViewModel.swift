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

    // MARK: - Life Cycle
    init(view: MovieListViewOutput) {
        self.view = view
    }

    // MARK: - Private Methods
    private func updateMovieList(_ movies: [Movie]) {
        moviesList = movies
        view.reloadMovieTableView()
    }

    // MARK: - Networking
    private func fetchMovies() {
        view.startFullScreenLoading()
        PopularMoviesEndpoint().makeRequest { (response, error) in
            self.view.stopFullScreenLoading()

            guard error == nil, let response = response else {
                self.view.showErrorMessage("FAILED_MOVIE_LIST_MESSAGE".localized, tryAgain: true)
                return
            }

            self.updateMovieList(response.movies)
        }
    }

    private func searchMovie(_ searchText: String) {
        guard !searchText.isEmpty else {
            fetchMovieList()
            return
        }

        view.startFullScreenLoading()
        SearchMovieEndpoint(searchText: searchText).makeRequest { (response, error) in
            self.view.stopFullScreenLoading()
            
            guard error == nil, let response = response else {
                self.view.showErrorMessage("FAILED_MOVIE_LIST_MESSAGE".localized, tryAgain: true)
                return
            }

            guard response.movies.count > 0 else {
                let errorMessage = "NO_MOVIE_FOUND".localized.replacingOccurrences(of: "%@", with: searchText)
                self.view.showErrorMessage(errorMessage, tryAgain: false)
                return
            }

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
        debouncer.debounce(delay: 0.75) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.searchMovie(text)
        }
    }

    func retrySearch(searchText: String?) {
        guard let text = searchText, !text.isEmpty else {
            fetchMovies()
            return
        }

        searchMovie(text)
    }

    func movieCount() -> Int {
        return moviesList.count
    }

    func movie(at position: Int) -> Movie {
        return moviesList[position]
    }
}
