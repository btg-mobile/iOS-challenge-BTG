//
//  FavoritesViewModel.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

class FavoritesViewModel {

    private weak var view: FavoritesViewOutput!

    private var favoriteList: [Movie] = []
    private var searchText = ""

    init(view: FavoritesViewOutput) {
        self.view = view
    }

    private func updateFavoritesList(_ favorites: [Movie], errorMessage: String, resetScroll: Bool) {
        favoriteList = favorites

        if favoriteList.count > 0 {
            view.reloadFavoriteTableView(resetScroll: resetScroll)
        } else {
            view.showErrorMessage(errorMessage)
        }
    }
}

extension FavoritesViewModel: FavoritesViewInput {
    func fetchFavoriteList() {
        let favorites = FavoritesManager.favoriteList()
        updateFavoritesList(favorites, errorMessage: "EMPTY_FAVORITES_MESSAGE".localized, resetScroll: false)
    }

    func didChangeSearchText(_ text: String) {
        searchText = text

        guard !text.isEmpty else {
            fetchFavoriteList()
            return
        }

        let favorites = FavoritesManager.favoriteList()
        guard favorites.count > 0 else {
            return
        }

        let filteredFavorites = favorites.filter { (movie) -> Bool in
            return movie.title.localizedCaseInsensitiveContains(text) || movie.releaseYear.contains(text)
        }
        updateFavoritesList(filteredFavorites, errorMessage: "NO_MOVIE_FOUND".localized.replacingOccurrences(of: "%@", with: text), resetScroll: true)
    }

    func resetSearch() {
        searchText = ""
    }

    func deleteFavorite(at position: Int) {
        let movie = favoriteList[position]
        favoriteList.remove(at: position)
        FavoritesManager.deleteFavorite(movie)

        if favoriteList.count == 0 {
            didChangeSearchText(searchText)
        }
    }

    func movieCount() -> Int {
        return favoriteList.count
    }

    func movie(at position: Int) -> Movie {
        return favoriteList[position]
    }
}
