//
//  FavoritesInteractor.swift
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
protocol FavoritesBusinessLogic {
    func fetchMovies()
    func favoriteMovie(movie: MoviesResult)
    func unfavoriteMovie(movie: MoviesResult)
}

protocol FavoritesDataStore {
    var movies: Observable<[MoviesResult]> { get }
    func movie(indexPath: IndexPath) -> MoviesResult
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore {
    
    // MARK: - Vars
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorker
    
    var movies: Observable<[MoviesResult]> {
        return moviesResponse.asObservable()
    }
    private var moviesResponse: BehaviorRelay<[MoviesResult]> = BehaviorRelay(value: [])
    
    // MARK: - Lets
    
    // MARK: - Initializers
    init(worker: FavoritesWorker) {
        self.worker = worker
    }
    
    convenience init() {
        self.init(worker: FavoritesWorker())
    }
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func movie(indexPath: IndexPath) -> MoviesResult {
        return self.moviesResponse.value[indexPath.row]
    }
    
    func fetchMovies() {
        worker.fetchMovies() { result in
            switch result {
            case .success(let result):
                var movies = result
                for index in 0..<movies.count {
                    self.worker.isFavorite(movie: movies[index], completion: { isFavorite in
                        movies[index].isFavorite = isFavorite
                    })
                }
                self.moviesResponse.accept(movies)
                self.presenter?.presentFetchedMovies()
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
