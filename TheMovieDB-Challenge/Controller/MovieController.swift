//
//  MovieController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 29/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieControllerDelegate : class {
    
    func successOnLoading()
    func errorOnLoading(error: Error?)
    
}

class MovieController {
    
    let realm = try! Realm()
    
    weak var delegate: MovieControllerDelegate?
    
    private var moviesArray : [Movie] = []
    private var notFilteredArray : [Movie] = []
    //Array de Favoritos
    private var favoriteMoviesArray : [Movie] = []
    
    var provider: MovieDataProvider?
    
    private func setupController(){
        self.provider = MovieDataProvider()
        self.provider?.delegate = self
        
    }
    
    func loadMovies(){
        
        self.setupController()
        
        self.provider?.getPopularMovies { result in
            
            switch result {
            case .failure (let error):
                print(error)
            case .success(let movies):
                
                //self.moviesArray = movies
                self.notFilteredArray = movies
                
                print("\(self.moviesArray.count) registros obtidos da API")
                
            }
            
        }
        
    }
    
    func numberOfRows() -> Int{
        
        return self.moviesArray.count
        
    }
    
    func loadMovieWithIndexPath(indexPath: IndexPath ) -> Movie {
        return (self.moviesArray[indexPath.row])
    }
    
    func searchByValue(searchText: String){
        guard !searchText.isEmpty else {
            self.moviesArray = self.notFilteredArray
            return
        }
        
        self.moviesArray = notFilteredArray.filter({ (Movie) -> Bool in
            (Movie.title?.lowercased().contains(searchText.lowercased()))!
        })
        
    }
    
    func updateArray(){
        self.moviesArray = self.notFilteredArray
    }
    
    //MARK: - Functions for DetailsVC
    
    func saveFavoriteMovie(movie: Movie?){
        
        if let selectedMovie = movie {
            let favorite = FavoriteMovie()
            favorite.title = selectedMovie.title!
            favorite.releaseDate = selectedMovie.releaseDate!
            favorite.overview = selectedMovie.overview!
            favorite.posterPath = selectedMovie.posterPath!
            favorite.voteAverage = selectedMovie.voteAverage!
            //favorite.genreIDS = selectedMovie.genreIDS!
        
        
        do {
            try realm.write {
                realm.add(favorite)
                print("Dados salvos no Realm com sucesso")
            }
        } catch {
            print("Erro ao salvar no Realm \(error)")
        }
        
        }
            
    }
    
    func loadFavoriteMovies(){
        
        var tempFavoriteMovieArray : Results<FavoriteMovie>!
        //var newFavoriteMovieArray
            
        tempFavoriteMovieArray = realm.objects(FavoriteMovie.self)
        
        for array in tempFavoriteMovieArray {
            
            print(array.title)
            
        }
        
        
    }
    
    //    func removeFavoriteMovie(index: Int){
    //
    //
    //
    //    }
    
    //    func numberOfRowsForFavorites() -> Int{
    //
    //
    //
    //    }
    //
    //    func loadMovieWithIndexPathForFavorites(indexPath: IndexPath ) -> Movie {
    //
    //
    //    }
    
    
}

extension MovieController : MovieDataProviderDelegate {
    func successOnLoading(movies: [Movie]?) {
        self.moviesArray = movies ?? []
        self.delegate?.successOnLoading()
    }
    
    func errorOnLoading(error: Error?) {
        self.delegate?.errorOnLoading(error: error)
    }
    
}
