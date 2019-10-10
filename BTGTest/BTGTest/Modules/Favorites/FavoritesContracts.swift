//
//  FavoritesContracts.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

protocol FavoritesViewOutput: class {
    func reloadFavoriteTableView(resetScroll: Bool)

    func showErrorMessage(_ message: String)
}

protocol FavoritesViewInput {
    func fetchFavoriteList()
    func didChangeSearchText(_ text: String)
    func resetSearch()

    func deleteFavorite(at position: Int)

    func movieCount() -> Int
    func movie(at position: Int) -> Movie
}
