//
//  FavoritesPresenter.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
protocol FavoritesPresentationLogic {
    func presentFetchedMovies()
    func presentError(error: ApiError)
    func moveToDetails()
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesPresenter: FavoritesPresentationLogic {
    
    // MARK: - Vars
    weak var viewController: FavoritesDisplayLogic?
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func presentFetchedMovies() {
        viewController?.displayFetchedMovies()
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
