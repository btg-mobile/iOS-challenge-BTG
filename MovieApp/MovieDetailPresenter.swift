//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Lucas Moraes on 12/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit

protocol MovieDetailPresenterProtocol {
    
    var viewCotroller: DisplayMovieDetailDisplayProtocol? { get }
    var movie: Movie? { get }
    
    func presentFavorite(movie: FavoriteMovie)
    func present(movie: Movie, thumb: UIImage)
    func presentErrorOnMovies(error: Error)
    
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    var viewCotroller: DisplayMovieDetailDisplayProtocol?
    var movie: Movie?
    
    func presentFavorite(movie: FavoriteMovie) {
        viewCotroller?.displayFavorite(movie: movie)
    }
    
    func present(movie: Movie, thumb: UIImage) {
        viewCotroller?.display(movie: movie, thumb: thumb)
    }
    
    func presentErrorOnMovies(error: Error) {
        viewCotroller?.displayErrorOnMovie(error: error)
    }
}
