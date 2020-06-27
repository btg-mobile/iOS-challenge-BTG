//
//  HomePresenter.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 24/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

class HomePresenter: HomeViewToPresenterProtocol {
    
    ///Layer instances
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    func getMovies(page: Int, category: Constants.category, movieSelection: Constants.MovieSelection) {
        
        interactor?.getMovies(page: page, category: category, movieSelection: movieSelection)
        
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func showMovieResults(movies: [Movie]) {
        
        self.view?.showMovieResults(movies: movies)
    }

}
