//
//  MovieController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 15/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import RealmSwift

protocol HomeControllerDelegate : class {
    
    func successOnLoadingPopularMovies()
    func successOnLoadingNowPlayingMovies()
    func successOnLoadingUpcomingMovies()
    func successOnLoadingTopRatedMovies()
    func errorOnLoading(error: Error?, type: Constants.MovieSelection)
    
}

class HomeController {
    
    let realm = try! Realm()
    
    weak var delegate: HomeControllerDelegate?
    
    private var favoriteMoviesArray: [Movie] = []
    
    private var popularMoviesArray: [Movie] = []
    private var nowPlayingMoviesArray: [Movie] = []
    private var upcomingMoviesArray: [Movie] = []
    private var topRatedMoviesArray: [Movie] = []
    
    private var genresArray: [GenreElement] = []
    
    var provider: MovieDataProvider?
    
    private func setupController() {
        
        //        self.provider = MovieDataProvider(page: 1, category: .movie, movieSelection: .upcoming)
        self.provider?.delegate = self
        
    }
    
    func loadMovies(from home: Bool, page: Int?, category: Constants.category, movieSelection: Constants.MovieSelection) {
        
        if home {
            
            self.setupController()
            
            self.provider = MovieDataProvider(page: page, category: category, movieSelection: .popular)
            self.provider?.delegate = self
            self.provider?.getMovies()

            self.provider = MovieDataProvider(page: page, category: category, movieSelection: .nowPlaying)
            self.provider?.delegate = self
            self.provider?.getMovies()

            self.provider = MovieDataProvider(page: page, category: category, movieSelection: .upcoming)
            self.provider?.delegate = self
            self.provider?.getMovies()

            self.provider = MovieDataProvider(page: page, category: category, movieSelection: .topRated)
            self.provider?.delegate = self
            self.provider?.getMovies()
            
        }else {
            
            //self.setupController()
            self.provider = MovieDataProvider(page: page, category: category, movieSelection: movieSelection)
            self.provider?.delegate = self
            self.provider?.getMovies()
            
        }
        
    }
    
    func numberOfRows(movieSelection: Constants.MovieSelection) -> Int {
        
        switch movieSelection {
        case .popular:
            return self.popularMoviesArray.count
        case .nowPlaying:
            return self.nowPlayingMoviesArray.count
        case .upcoming:
            return self.upcomingMoviesArray.count
        case .topRated:
            return self.topRatedMoviesArray.count
        }
        
    }
    
    func loadMovieWithIndexPath(indexPath: IndexPath, movieSelection: Constants.MovieSelection, favorite: Bool = false ) -> Movie {
        
        if favorite {
            return (self.favoriteMoviesArray[indexPath.row])
        }
        else {
            
            switch movieSelection {
            case .popular:
                return self.popularMoviesArray[indexPath.row]
            case .nowPlaying:
                return self.nowPlayingMoviesArray[indexPath.row]
            case .upcoming:
                return self.upcomingMoviesArray[indexPath.row]
            case .topRated:
                return self.topRatedMoviesArray[indexPath.row]
            }
            
        }
        
    }
    
}
//MARK:- EXT DO PROTOCOLO

extension HomeController : MovieDataProviderDelegate {
    
    func getTotalPages(_ totalOfPages: Int) {
        ///
    }
        
    func successOnLoading(_ movies: [Movie]?, movieSelection: Constants.MovieSelection) {

        switch movieSelection {
        case .popular:
            self.popularMoviesArray = movies ?? []
            self.delegate?.successOnLoadingPopularMovies()
            
        case .nowPlaying:
            self.nowPlayingMoviesArray = movies ?? []
            self.delegate?.successOnLoadingNowPlayingMovies()
            
        case .upcoming:
            self.upcomingMoviesArray = movies ?? []
            self.delegate?.successOnLoadingUpcomingMovies()
            
        case .topRated:
            self.topRatedMoviesArray = movies ?? []
            self.delegate?.successOnLoadingTopRatedMovies()
        }
        
    }
    
    func errorOnLoading(error: Error?) {
        
        self.delegate?.errorOnLoading(error: error, type: .nowPlaying)
        
    }
    
}
