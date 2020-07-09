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
        
        NetworkingService.shared.getMovies(page: page, category: category, movieSelection: movieSelection) { (movieHeader, success, error) in
            
            if success {
                
                guard let movieHeader = movieHeader else {
                    return
                }
                
                self.presenter?.returnMovieResults(movieHeader: movieHeader)
                
            }
            else {
                
                if let error = error {
                    
                    self.presenter?.problemOnFetchingData(error: error)
                    
                }
                
            }
            
        }
        
    }
    
}
