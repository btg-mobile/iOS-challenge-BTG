//
//  MovieDetailsPresenter.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
protocol MovieDetailsPresentationLogic {
    func presentSomething(response: MovieDetails.Response)
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    
    // MARK: - Vars
    weak var viewController: MovieDetailsDisplayLogic?
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func presentSomething(response: MovieDetails.Response) {
        let viewModel = MovieDetails.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
