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
    func reloadMovieTableView(resetScroll: Bool)

    func startFullScreenLoading()
    func stopFullScreenLoading()

    func showErrorMessage(_ message: String, tryAgain: Bool)
}

protocol MovieListViewInput {
    func fetchMovieList()
    func didChangeSearchText(_ text: String)
    func retrySearch(searchText: String?)

    func movieCount() -> Int
    func movie(at position: Int) -> Movie

    func willDisplayCell(at position: Int, searchText: String?)
}
