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
    func fetchMovies(request: Movies.Request)
    func favoriteMovie(movie: MoviesResult)
}

protocol MoviesDataStore {
    var movies: Observable<[MoviesResult]> { get }
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
    func fetchMovies(request: Movies.Request) {
        if request.page == 1 {
            moviesResponse.accept([])
        }
        worker.fetchMovies(page: request.page) { result in
            switch result {
            case .success(let result):
                var movies = self.moviesResponse.value
                movies.append(contentsOf: result.results)
                self.moviesResponse.accept(movies)
                let response = Movies.Response(moviesResponse: result, errorMessage: nil)
                self.presenter?.presentFetchedMovies(response: response)
            case .failure(let error):
                let response = Movies.Response(moviesResponse: nil, errorMessage: error.message)
                self.presenter?.presentFetchedMovies(response: response)
            }
        }
    }
    
    func favoriteMovie(movie: MoviesResult) {
        worker.favoriteMovie(movie: movie) { error in
            if let error = error {
                self.presenter?.presentError(response: Movies.Response(moviesResponse: nil, errorMessage: error.localizedDescription))
            }
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
