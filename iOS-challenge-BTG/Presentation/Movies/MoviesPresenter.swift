//
//  MoviesPresenter.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
protocol MoviesPresentationLogic {
    func presentFetchedMovies(response: MoviesResponse)
    func presentError(error: ApiError)
    func moveToDetails()
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesPresenter: MoviesPresentationLogic {
    
    // MARK: - Vars
    weak var viewController: MoviesDisplayLogic?
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func presentFetchedMovies(response: MoviesResponse) {
        viewController?.displayFetchedMovies(response: response)
    }
    
    func presentError(error: ApiError) {
        viewController?.displayError(message: error.message)
    }
    
    func moveToDetails() {
        viewController?.displayDetails()
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
