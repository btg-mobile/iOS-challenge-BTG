//
//  HomePresenter.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 24/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import RealmSwift

class HomePresenter: HomeViewToPresenterProtocol {
    
    //let realm = try! Realm()
    
    ///Layer instances
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    ///Local Data Arrays
    private var favoriteMoviesArray: [Movie] = []
    private var moviesArray: [Movie] = []
    
    func getMovies(page: Int, category: Constants.category, movieSelection: Constants.MovieSelection) {
        
        interactor?.getMovies(page: page, category: category, movieSelection: movieSelection)
        
    }
    
    func numberOfSections() -> Int {
        
        return 4 //return moviesArray.count
        
    }
    
    func getNumberOfRowsInSection() -> Int {
        
        return moviesArray.count
        
    }
    
    func loadMovieWithIndexPath(indexPath: IndexPath, movieSelection: Constants.MovieSelection, favorite: Bool = false ) -> Movie {
        
        if favorite {
            
            return favoriteMoviesArray[indexPath.row]
            
        }else {
            
            return moviesArray[indexPath.row]
            
        }
        
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func returnMovieResults(movies: [Movie]) {
        
        moviesArray = movies
        view?.showMovieResults()
        
    }
    
    func problemOnFetchingData(error: Constants.errorTypes) {
        
        view?.problemOnFetchingData(error: error)
        
    }
    
}
