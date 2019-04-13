//
//  FavoritesInteractor.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
protocol FavoritesBusinessLogic {
    func doSomething(request: Favorites.Request)
}

protocol FavoritesDataStore {
    //var name: String { get set }
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore {
    
    // MARK: - Vars
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorker?
    
    // MARK: - Lets
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func doSomething(request: Favorites.Request) {
        worker = FavoritesWorker()
        worker?.doSomeWork()
        
        let response = Favorites.Response()
        presenter?.presentSomething(response: response)
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
