//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import Foundation

protocol MoviePresenterLogic {
    func presentPopularMovies(with movies: [Movie])
    func presentPopularMoviesError(with error: MovieError)
    func presentPopularMoviesUsingPage(with movie: [Movie])
    
    var viewController: DisplayMoviesProtocol? { get }
}

class MoviePresenter: MoviePresenterLogic {
    
    var viewController: DisplayMoviesProtocol?
    
    func presentPopularMovies(with movies: [Movie]) {
        viewController?.displayMovies(movies: movies)
    }
    
    func presentPopularMoviesError(with error: MovieError) {
        viewController?.displayErrorMovies(movieError: error)
    }
    
    func presentPopularMoviesUsingPage(with movie: [Movie]) {
        viewController?.displayMovieUsingPage(movies: movie)
    }
}
