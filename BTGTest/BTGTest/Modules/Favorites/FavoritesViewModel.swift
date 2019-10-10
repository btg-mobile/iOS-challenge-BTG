//
//  FavoritesViewModel.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

class FavoritesViewModel {

    enum SortOption: CaseIterable {
        case title
        case year
    }

    private weak var view: FavoritesViewOutput!

    private var favoriteList: [Movie] = []
    private var searchText = ""

    private var sortingBy: SortOption = .title

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

    private func sort(movies: [Movie]) -> [Movie] {
        switch sortingBy {
        case .title:
            return movies.sorted { (movie1, movie2) -> Bool in
                movie1.title.lowercased() < movie2.title.lowercased()
            }
        case .year:
            return movies.sorted { (movie1, movie2) -> Bool in
                movie1.releaseDate < movie2.releaseDate
            }
        }
    }
}

extension FavoritesViewModel: FavoritesViewInput {
    func fetchFavoriteList() {
        var favorites = FavoritesManager.favoriteList()
        favorites = sort(movies: favorites)
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

        var filteredFavorites = favorites.filter { (movie) -> Bool in
            return movie.title.localizedCaseInsensitiveContains(text) || movie.releaseYear.contains(text)
        }

        filteredFavorites = sort(movies: filteredFavorites)
        updateFavoritesList(filteredFavorites, errorMessage: "NO_MOVIE_FOUND".localized.replacingOccurrences(of: "%@", with: text), resetScroll: true)
    }

    func resetSearch() {
        searchText = ""
    }

    func updateSorting(typeValue: Int) {
        sortingBy = SortOption.allCases[typeValue]
        didChangeSearchText(searchText)
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
