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

    private var favoriteMoviesArray : [Movie] = []
    private var notFilteredFavoriteMoviesArray : [Movie] = []
    
    private var genresArray : [GenreElement] = []
    
    var provider: MovieDataProvider?
    
    private func setupController(){
        self.provider = MovieDataProvider()
        self.provider?.delegate = self
        
        self.removeAll()
        self.saveGenresIntoRealm()
        
    }

    func removeAll(){
        
        let realm = try! Realm()
         let allUploadingObjects = realm.objects(Item.self)

         try! realm.write {
             realm.delete(allUploadingObjects)
         }
    }
    
    func saveGenresIntoRealm(){
        
        self.provider?.getGenreIds { (allGenres) in
            
            for i in allGenres.genres {
                
                let realm = try! Realm()
                
                let item = Item()
                item.id = i.id
                item.name = i.name
                
                try! realm.write {
                    realm.add(item)
                }
                
            }
                    
        }
    
    }
    
    func loadMovies(){
        
        self.setupController()
        
        self.provider?.getPopularMovies { result in
            
            switch result {
            case .failure (let error):
                print(error)
            case .success(let movies):
                
                self.notFilteredArray = movies
                
                print("\(self.moviesArray.count) registros obtidos da API")
                
            }
            
        }
        
    }
    
    func numberOfRows() -> Int{
        
        return self.moviesArray.count
        
    }
    
    func loadMovieWithIndexPath(indexPath: IndexPath, favorite: Bool ) -> Movie {
        if !favorite {
            return (self.moviesArray[indexPath.row])
        }
        else{
            return (self.favoriteMoviesArray[indexPath.row])
        }
        
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
    
    func searchFavoriteByValue(searchText: String){
        guard !searchText.isEmpty else {
            self.favoriteMoviesArray = self.notFilteredFavoriteMoviesArray
            return
        }
        
        self.favoriteMoviesArray = notFilteredFavoriteMoviesArray.filter({ (Movie) -> Bool in
            
            (Movie.releaseDate?.lowercased().contains(searchText.lowercased()))! || (Movie.title?.lowercased().contains(searchText.lowercased()))!
            
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
            favorite.backdropPath = selectedMovie.backdropPath!
            favorite.voteAverage = selectedMovie.voteAverage!
            
            for i in movie?.genreIDS ?? [] {
                
                do{
                    try self.realm.write {
                        let newItem = IntGenreID()
                        newItem.id = i
                        favorite.items.append(newItem)
                    }
                }catch{
                    print("Erro ao gravar os dados na base realm")
                }
                
            }
            
            favorite.popularity = selectedMovie.popularity!
            favorite.voteCount = selectedMovie.voteCount!
            favorite.video = selectedMovie.video!
            favorite.id = selectedMovie.id!
            favorite.adult = selectedMovie.adult!
            favorite.originalLanguage = selectedMovie.originalLanguage!
            favorite.originalTitle = selectedMovie.originalTitle!
            
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
        
        self.favoriteMoviesArray.removeAll()
        //Realm Array
        var tempFavoriteMovieArray : Results<FavoriteMovie>?
        tempFavoriteMovieArray = realm.objects(FavoriteMovie.self)
        
        if let array = tempFavoriteMovieArray {
            
            for i in array {
                
                let title = i.title
                let backdropPath = i.backdropPath
                let overview = i.overview
                let voteAverage = i.voteAverage
                
                let array = i.items
                
                var genreIDS : [Int]? = []
                
                for i in array {
                    
                    genreIDS?.append(i.id)
                    
                }
                
                let popularity = i.popularity
                let voteCount = i.voteCount
                let video = i.video
                let posterPath = i.posterPath
                let id = i.id
                let adult = i.adult
                let originalLanguage = i.originalLanguage
                let originalTitle = i.originalTitle
                let releaseDate = i.releaseDate
                
                let movie : Movie? = Movie(popularity: popularity, voteCount: voteCount, video: video, posterPath: posterPath, id: id, adult: adult, backdropPath: backdropPath, originalLanguage: originalLanguage, originalTitle: originalTitle, genreIDS: genreIDS, title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate)
                
                self.favoriteMoviesArray.append(movie!)//passou do if let
                genresArray.removeAll()
            }
            
            print("\(favoriteMoviesArray.count) Filme no array Favoritos")
            print("########")
            notFilteredFavoriteMoviesArray = favoriteMoviesArray
        }
        
    }
    
    //MARK:- VERIFICA SE JA É FAVORITO
    func isFavorite(id: Int) -> Bool {
        
        let check = realm.objects(FavoriteMovie.self).filter("id = \(id)")
        if check.count != 0 {
            return true
        }
        
        return false
        
    }
    
    func removeFavoriteMovie(id: Int){
        
        let check = realm.objects(FavoriteMovie.self).filter("id = \(id)")
        
        do{
            try realm.write {
                realm.delete(check)
            }
        }
        catch{
            print("Erro ao remover registro : \(error)")
        }
        
    }
    
    func updateFavoriteArray(){
        self.favoriteMoviesArray = self.notFilteredFavoriteMoviesArray
    }
    
    func numberOfRowsForFavorites() -> Int{
        
        return self.favoriteMoviesArray.count
        
    }
    
    func loadMovieWithIndexPathForFavorites(indexPath: IndexPath ) -> Movie {
        
        return self.favoriteMoviesArray[indexPath.row]
        
    }
    
}

//MARK:- EXT DO PROTOCOLO

extension MovieController : MovieDataProviderDelegate {
    func successOnLoading(movies: [Movie]?) {
        self.moviesArray = movies ?? []
        self.delegate?.successOnLoading()
    }
    
    func errorOnLoading(error: Error?) {
        self.delegate?.errorOnLoading(error: error)
    }
    
}

