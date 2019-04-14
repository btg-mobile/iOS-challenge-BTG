//
//  MovieDetailsRouter.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
@objc protocol MovieDetailsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MovieDetailsDataPassing {
    var dataStore: MovieDetailsDataStore? { get }
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MovieDetailsRouter: NSObject, MovieDetailsRoutingLogic, MovieDetailsDataPassing {
    
    // MARK: - Vars
    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
