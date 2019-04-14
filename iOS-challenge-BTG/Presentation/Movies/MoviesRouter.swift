//
//  MoviesRouter.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
@objc protocol MoviesRoutingLogic {
    func routeDetails()
}

protocol MoviesDataPassing {
    var dataStore: MoviesDataStore? { get }
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesRouter: NSObject, MoviesRoutingLogic, MoviesDataPassing {
    
    // MARK: - Vars
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func routeDetails() {
        let destinationVC = MovieDetailsViewController.instantiate()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetails(source: dataStore!, destination: &destinationDS)
        navigateToDetails(source: viewController!, destination: destinationVC)
    }
    
    func navigateToDetails(source: MoviesViewController, destination: MovieDetailsViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func passDataToDetails(source: MoviesDataStore, destination: inout MovieDetailsDataStore) {
        destination.id = source.id
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
