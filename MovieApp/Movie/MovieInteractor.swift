//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import Foundation

protocol MovieInteractorLogic {
    func getMovies()
    func getMovies(withPages page: Int)
    var movies: [Movie]? { get }
}

class MovieInteractor: MovieInteractorLogic {
    var movies: [Movie]?
    
    var presenter: MoviePresenter?
    var worker = MovieWorker()
    
    func getMovies() {
        worker.downloadPopularMovies { [weak self] (movie, movieError) in
            
            guard let movieInteractor = self else { return }
            
            if movieError != nil {
                movieInteractor.presenter?.presentPopularMoviesError(with: movieError!)
            } else {
                movieInteractor.movies = movie
                movieInteractor.presenter?.presentPopularMovies(with: movieInteractor.movies!)
            }
        }
    }
    
    func getMovies(withPages page: Int) {
        worker.downloadPopularMovies(withPage: page) {  [weak self] (movie, movieError) in
            
            guard let movieInteractor = self else { return }
            
            if movieError != nil {
                movieInteractor.presenter?.presentPopularMoviesError(with: movieError!)
            } else {
                movieInteractor.movies = movie
                movieInteractor.presenter?.presentPopularMoviesUsingPage(with: movieInteractor.movies!)
            }
        }
    }
}

