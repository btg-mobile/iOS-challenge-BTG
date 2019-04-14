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
    var movies: Observable<[Movie]> { get }
    func fetchMovies()
    func favoriteMovie(movie: Movie)
    func unfavoriteMovie(movie: Movie)
    func movie(indexPath: IndexPath) -> Movie
    func setId(id: Int)
}

protocol FavoritesDataStore {
    var id: Int { get }
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore {
    
    // MARK: - Vars
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorker
    
    var movies: Observable<[Movie]> {
        return moviesResponse.asObservable()
    }
    var id: Int = 0
    private var moviesResponse: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
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
    func movie(indexPath: IndexPath) -> Movie {
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
                if self.moviesResponse.value.isEmpty {
                    self.presenter?.presentEmpty()
                } else {
                    self.presenter?.presentFetchedMovies()
                }
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func favoriteMovie(movie: Movie) {
        worker.favoriteMovie(movie: movie) { error in
            if let error = error {
                self.presenter?.presentError(error: ApiError.standard(error: error))
            } else {
                self.fetchMovies()
            }
        }
    }
    
    func unfavoriteMovie(movie: Movie) {
        worker.unfavoriteMovie(movie: movie) { error in
            if let error = error {
                self.presenter?.presentError(error: ApiError.standard(error: error))
            } else {
                self.fetchMovies()
            }
        }
    }
    
    func setId(id: Int) {
        self.id = id
        self.presenter?.moveToDetails()
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
