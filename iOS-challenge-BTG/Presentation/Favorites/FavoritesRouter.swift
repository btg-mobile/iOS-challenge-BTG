//
//  FavoritesRouter.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
@objc protocol FavoritesRoutingLogic {
    func routeDetails()
}

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesRouter: NSObject, FavoritesRoutingLogic, FavoritesDataPassing {
    
    // MARK: - Vars
    weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?
    
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
    
    func navigateToDetails(source: FavoritesViewController, destination: MovieDetailsViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func passDataToDetails(source: FavoritesDataStore, destination: inout MovieDetailsDataStore) {
        destination.id = source.id
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
