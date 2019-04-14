//
//  MoviesInteractor.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit
import RxSwift
import RxCocoa

// MARK: - Typealias

// MARK: - Protocols
protocol MoviesBusinessLogic {
    func fetchMovies(page: Int)
    func favoriteMovie(movie: MoviesResult)
    func unfavoriteMovie(movie: MoviesResult)
}

protocol MoviesDataStore {
    var movies: Observable<[MoviesResult]> { get }
    func movie(indexPath: IndexPath) -> MoviesResult
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    
    // MARK: - Vars
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorker
    
    var movies: Observable<[MoviesResult]> {
        return moviesResponse.asObservable()
    }
    private var moviesResponse: BehaviorRelay<[MoviesResult]> = BehaviorRelay(value: [])
    
    // MARK: - Lets
    
    // MARK: - Initializers
    init(worker: MoviesWorker) {
        self.worker = worker
    }
    
    convenience init() {
        self.init(worker: MoviesWorker())
    }
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func movie(indexPath: IndexPath) -> MoviesResult {
        return self.moviesResponse.value[indexPath.row]
    }
    
    func fetchMovies(page: Int) {
        if page == 1 {
            moviesResponse.accept([])
        }
        worker.fetchMovies(page: page) { result in
            switch result {
            case .success(let result):
                var movies = self.moviesResponse.value
                movies.append(contentsOf: result.results)
                for index in 0..<movies.count {
                    self.worker.isFavorite(movie: movies[index], completion: { isFavorite in
                        movies[index].isFavorite = isFavorite
                    })
                }
                self.moviesResponse.accept(movies)
                self.presenter?.presentFetchedMovies(response: result)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func favoriteMovie(movie: MoviesResult) {
        worker.favoriteMovie(movie: movie) { error in
            if let error = error {
                self.presenter?.presentError(error: ApiError.standard(error: error))
            }
        }
    }
    
    func unfavoriteMovie(movie: MoviesResult) {
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
