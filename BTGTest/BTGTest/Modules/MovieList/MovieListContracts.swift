//
//  MovieListContracts.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

// MARK: - MovieList View Contracts
protocol MovieListViewOutput: class {
    func reloadMovieCollectionView(resetScroll: Bool)
    func reloadMovieTableView(resetScroll: Bool)

    func startFullScreenLoading()
    func stopFullScreenLoading()

    func showErrorMessage(_ message: String, tryAgain: Bool)
}

protocol MovieListViewInput {
    func fetchMovieList()
    func didChangeSearchText(_ text: String)
    func retrySearch()
    func resetSearch()

    func movieCount() -> Int
    func movie(at position: Int) -> Movie

    func toggleFavorite(at position: Int)
    func isMovieFavorited(movie: Movie) -> Bool

    func willDisplayCell(at position: Int)
}
