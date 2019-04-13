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
    func doSomething(request: MovieDetails.Request)
}

protocol MovieDetailsDataStore {
    //var name: String { get set }
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    // MARK: - Vars
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorker?
    //var name: String = ""
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func doSomething(request: MovieDetails.Request) {
        worker = MovieDetailsWorker()
        worker?.doSomeWork()
        
        let response = MovieDetails.Response()
        presenter?.presentSomething(response: response)
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
