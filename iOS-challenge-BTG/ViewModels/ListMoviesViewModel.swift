//
//  ListMoviesViewModel.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

class ListMoviesViewModel {

    let viewTitle = "Filmes populares"
    let movieService = MovieService()
    let genreService = GenreService()
    var movieViewModel = MovieViewModel()
    var genres: [Genre] = []
    var isLoadingMoreData = false
}

// MARK: - Requests
extension ListMoviesViewModel {

    func fetchPopularMovies(nextPage: Bool, completion: @escaping (MovieViewModel) -> ()) {

        if isLoadingMoreData {
            return
        }

        isLoadingMoreData = true

        var page = self.movieViewModel.page

        if nextPage {
            if page >= self.movieViewModel.totalPages {
                return
            }
            page += 1
        }

        self.movieService.fetchPopularMovies(with: page) {
            (viewModel, serviceError) in

            self.isLoadingMoreData = false
            
            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let viewModel = viewModel {
                self.movieViewModel.page = viewModel.page
                self.movieViewModel.totalPages = viewModel.totalPages
                self.movieViewModel.movies.append(contentsOf: viewModel.movies)

                completion(self.movieViewModel)
            }
        }
    }

    func fetchGenres(completion: @escaping ([Genre]) -> ()) {
        self.genreService.fetchGenres { (genres, serviceError) in
            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let genres = genres {
                self.genres = genres
                completion(genres)
            }
        }
    }
}
