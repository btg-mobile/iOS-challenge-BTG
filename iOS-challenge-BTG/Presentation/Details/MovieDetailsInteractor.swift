//
//  MovieDetailsInteractor.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
protocol MovieDetailsBusinessLogic {
    func fetchMovie()
    func favoriteMovie(movie: Movie)
    func unfavoriteMovie(movie: Movie)
}

protocol MovieDetailsDataStore {
    var id: Int { get set }
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    // MARK: - Vars
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorker
    var id: Int = 0
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    init(worker: MovieDetailsWorker) {
        self.worker = worker
    }
    
    convenience init() {
        self.init(worker: MovieDetailsWorker())
    }
    
    // MARK: - Public Methods
    func fetchMovie() {
        worker.fetchMovie(movieId: self.id) { result in
            switch result {
            case .success(let result):
                var movie: Movie = result
                self.worker.isFavorite(movie: movie, completion: { isFavorite in
                    movie.isFavorite = isFavorite
                })
                self.presenter?.presentFetchedMovie(movie: movie)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func favoriteMovie(movie: Movie) {
        worker.favoriteMovie(movie: movie) { error in
            if let error = error {
                self.presenter?.presentError(error: ApiError.standard(error: error))
            }
        }
    }
    
    func unfavoriteMovie(movie: Movie) {
        worker.unfavoriteMovie(movie: movie) { error in
            if let error = error {
                self.presenter?.presentError(error: ApiError.standard(error: error))
            }
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
