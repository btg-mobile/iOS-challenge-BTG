//
//  MovieController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 15/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import RealmSwift

class HomeInteractor: HomePresenterToInteractorProtocol {

    var presenter: HomeInteractorToPresenterProtocol?
    
    func getMovies(page: Int, category: Constants.category, movieSelection: Constants.MovieSelection) {
        
        WebService.shared.getMovies(page: page, category: category, movieSelection: movieSelection) { (movies, success, error) in
            
            if success {
                self.presenter?.returnMovieResults(movies: movies ?? [])
            }
            else {
                if let error = error {
                    self.presenter?.problemOnFetchingData(error: error)
                }
            }
            
        }
        
    }
    
}
