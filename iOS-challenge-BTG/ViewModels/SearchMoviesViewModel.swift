//
//  SearchMoviesViewModel.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 21/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation
import UIKit

class SearchMoviesViewModel {

    let movieService = MovieService()
    let movieDataSource = MovieDataSource()
    var movieViewModel = MovieViewModel()
    var sender = UIViewController()
    var isLoadingMoreData = false
}

extension SearchMoviesViewModel {

    func fetchMovies(search: String, nextPage: Bool, completion: @escaping (MovieViewModel) -> ()) {
        if sender.isKind(of: ListFavoritesViewController.self) {
            fetchDataStoreMovies(search: search, nextPage: nextPage, completion: completion)
        } else {
            fetchServiceMovies(search: search, nextPage: nextPage, completion: completion)
        }
    }

    func fetchServiceMovies(search: String, nextPage: Bool, completion: @escaping (MovieViewModel) -> ()) {

        if nextPage {
            if isLoadingMoreData {
                return
            }
            isLoadingMoreData = true
        }

        guard var page = self.movieViewModel.page else { return }

        if nextPage {
            guard let totalPages = self.movieViewModel.totalPages else { return }
            if page >= totalPages {
                return
            }
            page += 1
        }

        self.movieViewModel.search = search

        self.movieService.fetchMovies(with: search, page: page) {
            (viewModel, serviceError) in

            self.isLoadingMoreData = false

            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let viewModel = viewModel {
                self.movieViewModel.page = viewModel.page
                self.movieViewModel.totalPages = viewModel.totalPages
                if nextPage {
                    self.movieViewModel.movies?.append(contentsOf: viewModel.movies ?? [])
                } else {
                    self.movieViewModel.movies = viewModel.movies
                }

                completion(self.movieViewModel)
            }
        }
    }

    func fetchDataStoreMovies(search: String, nextPage: Bool, completion: @escaping (MovieViewModel) -> ()) {

        if nextPage {
            if isLoadingMoreData {
                return
            }
            isLoadingMoreData = true
        }

        guard var page = self.movieViewModel.page else { return }

        if nextPage {
            guard let totalPages = self.movieViewModel.totalPages else { return }
            if page >= totalPages {
                isLoadingMoreData = false
                return
            }
            page += 1
        }

        self.movieViewModel.search = search

        self.movieDataSource.fetchMovies(search: search, page: page) {
            (viewModel, serviceError) in

            self.isLoadingMoreData = false

            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let viewModel = viewModel {
                self.movieViewModel.page = viewModel.page
                self.movieViewModel.totalPages = viewModel.totalPages
                if nextPage {
                    self.movieViewModel.movies?.append(contentsOf: viewModel.movies ?? [])
                } else {
                    self.movieViewModel.movies = viewModel.movies
                }

                completion(self.movieViewModel)
            }
        }
    }
}
