//
//  Favorite.swift
//  TheMovieDB
//
//  Created by Usuario on 30/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoriteWorker {
    var dataManager: DataManager
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }
    
    func createMovie(movie: Movie) -> Bool {
        let managedContext = dataManager.container.viewContext
        guard let entity = NSEntityDescription
            .entity(forEntityName: "MovieDataSource", in: managedContext) else {
                return false
        }
        let movieDataSource = NSManagedObject(entity: entity, insertInto: managedContext)
        
        var genres = ""
        if let currentGenreIds = movie.genreIds,
            currentGenreIds.count > 0 {
            let array = currentGenreIds.map { String($0) }
            genres = array.joined(separator: ",")
        }
        
        movieDataSource.setValue(movie.id, forKey: "id")
        movieDataSource.setValue(movie.title, forKey: "title")
        movieDataSource.setValue(genres, forKey: "genreIds")
        movieDataSource.setValue(movie.overview, forKey: "overview")
        movieDataSource.setValue(movie.releaseDate, forKey: "releaseDate")
        movieDataSource.setValue(movie.posterPath, forKey: "posterPath")
        movieDataSource.setValue(movie.voteAverage, forKey: "voteAverage")
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func getMovies() -> [MovieDataSource] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDataSource")
        let context = dataManager.container.viewContext
        
        do {
            let movies = try context.fetch(fetchRequest)
            guard let currentMovies = movies as? [MovieDataSource] else { return [] }
            return currentMovies
        } catch {
            print("Error when getting movies")
            return []
        }
    }
    
    func deleteMovie(movieId: Int64) -> Bool {
        let currentMovies = getMovies()
        let result = currentMovies.filter { (movie: MovieDataSource) -> Bool in
            return movie.id == movieId
        }
        let managedContext = dataManager.container.viewContext
        if result.count > 0, let currentMovie = result.first {
            do {
                managedContext.delete(currentMovie)
                try managedContext.save()
                return true
            } catch {
                print("error when deleting movie")
                return false
            }
        } else {
            return false
        }
    }
    
    func isFavorite(movieId: Int64) -> Bool {
        let currentMovies = getMovies()
        let result = currentMovies.filter { (movie: MovieDataSource) -> Bool in
            return movie.id == movieId
        }
        if result.count > 0 {
            return true
        }
        return false
    }
}
