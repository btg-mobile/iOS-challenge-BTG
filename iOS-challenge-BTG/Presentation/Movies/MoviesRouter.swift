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
    //func routeToSomewhere(segue: UIStoryboardSegue?)
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
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    //func navigateToSomewhere(source: MoviesViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    //func passDataToSomewhere(source: MoviesDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
