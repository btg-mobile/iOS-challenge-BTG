//
//  FavoritesWorker.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit
import RxSwift

// MARK: - Typealias

// MARK: - Protocols

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesWorker {
    
    // MARK: - Vars
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Lets
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func fetchMovies(completion: @escaping (Result<[Movie], ApiError>) -> Void) {
        MoviesService.shared.movies.subscribe(onSuccess: { success in
            completion(.success(success))
        }, onError: { error in
            completion(.failure(ApiError.standard(error: error)))
        }).disposed(by: self.disposeBag)
    }
    
    func favoriteMovie(movie: Movie, completion: @escaping (Error?) -> Void) {
        MoviesService.shared.favorite(movie: movie).subscribe(onCompleted: {
            completion(nil)
        }, onError: { error in
            completion(error)
        }).disposed(by: disposeBag)
    }
    
    func unfavoriteMovie(movie: Movie, completion: @escaping (Error?) -> Void) {
        MoviesService.shared.unfavorite(movie: movie).subscribe(onCompleted: {
            completion(nil)
        }, onError: { error in
            completion(error)
        }).disposed(by: disposeBag)
    }
    
    func isFavorite(movie: Movie, completion: @escaping (Bool) -> Void) {
        completion(MoviesService.shared.isFavorite(movie: movie))
    }
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
