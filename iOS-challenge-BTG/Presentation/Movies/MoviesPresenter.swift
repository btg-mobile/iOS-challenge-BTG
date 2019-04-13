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
    func presentFetchedMovies(response: Movies.Response)
    func presentError(response: Movies.Response)
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
    func presentFetchedMovies(response: Movies.Response) {
        if let movies = response.moviesResponse {
            let viewModel = Movies.ViewModel(movies: movies, errorMessage: nil)
            viewController?.displayFetchedMovies(viewModel: viewModel)
        } else if let message = response.errorMessage {
            let viewModel = Movies.ViewModel(movies: nil, errorMessage: message)
            viewController?.displayError(viewModel: viewModel)
        } else {
            let viewModel = Movies.ViewModel(movies: nil, errorMessage: K.Messages.Unknown)
            viewController?.displayError(viewModel: viewModel)
        }
    }
    
    func presentError(response: Movies.Response) {
        if let message = response.errorMessage {
            let viewModel = Movies.ViewModel(movies: nil, errorMessage: message)
            viewController?.displayError(viewModel: viewModel)
        } else {
            let viewModel = Movies.ViewModel(movies: nil, errorMessage: K.Messages.Unknown)
            viewController?.displayError(viewModel: viewModel)
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
