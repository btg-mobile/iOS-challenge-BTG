//
//  MoviesWorker.swift
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
class MoviesWorker {
    
    // MARK: - Vars
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Lets
    private let disposeBag = DisposeBag()
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, ApiError>) -> Void) {
        MoviesService.shared.popular(page: page).do(onSuccess: { success in
            completion(success)
        }, onError: { error in
            completion(.failure(ApiError.standard(error: error)))
        }, onSubscribe: {
            print("onSubscribe")
        }).subscribe().disposed(by: disposeBag)
    }
    
    func favoriteMovie(movie: MoviesResult, completion: @escaping (Error?) -> Void) {
        MoviesService.shared.favorite(movie: movie).subscribe(onCompleted: { 
            completion(nil)
        }, onError: { error in
            completion(error)
        }).disposed(by: disposeBag)
    }
    
    func unfavoriteMovie(movie: MoviesResult, completion: @escaping (Error?) -> Void) {
        MoviesService.shared.unfavorite(movie: movie).subscribe(onCompleted: {
            completion(nil)
        }, onError: { error in
            completion(error)
        }).disposed(by: disposeBag)
    }
    
    func isFavorite(movie: MoviesResult, completion: @escaping (Bool) -> Void) {
        completion(MoviesService.shared.isFavorite(movie: movie))
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
