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
    private var favoriteMoviesArray: [[Movie]] = []
    private var moviesArray: [[Movie]] = []
    private var sectionNames: [String] = []
    
    func getMovies(page: Int, category: Constants.category, movieSelection: Constants.MovieSelection) {
        
        interactor?.getMovies(page: page, category: category, movieSelection: movieSelection)
        
    }
    
    func getNumberOfSections() -> Int {
        
        return moviesArray.count
        
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        
        return moviesArray[section].count
        
    }
    
    func loadMovieArrayWithIndexPath(indexPath: IndexPath) -> [Movie] {
        
        return moviesArray[indexPath.row]
        
    }
    
    func requestFirstCallOfMovies() {
        
        moviesArray.removeAll()
        
        interactor?.getMovies(page: 1, category: .Movie, movieSelection: Constants.MovieSelection.Popular)
        interactor?.getMovies(page: 1, category: .Movie, movieSelection: Constants.MovieSelection.NowPlaying)
        interactor?.getMovies(page: 1, category: .Movie, movieSelection: Constants.MovieSelection.TopRated)
        interactor?.getMovies(page: 1, category: .Movie, movieSelection: Constants.MovieSelection.Upcoming)
        
    }
    
    func getCategoryName(section: Int) -> String {
        
        return sectionNames[section]
    
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func returnMovieResults(movieHeader: MovieHeader) {
        
        let sectionName = { () -> String in
            
            switch movieHeader.categoryType?.rawValue ?? "" {
                
            case "popular":
                return "Popular"
            case "now_playing":
                return "Now Playing"
            case "upcoming":
                return "Upcoming"
            case "top_rated":
                return "Top Rated"
            default:
                return ""
            }
            
        }()
        
        sectionNames.append(sectionName)
        moviesArray.append(movieHeader.movies ?? [])
        view?.showMovieResults()
        
    }
    
    func problemOnFetchingData(error: Constants.errorTypes) {
        
        view?.problemOnFetchingData(error: error)
        
    }
    
}
