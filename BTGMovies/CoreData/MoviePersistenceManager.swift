//
//  MoviePersistenceManager.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import CoreData

class MoviePersistenceManager: CoreDataManager {
    
    internal typealias T = MoviePersistence
    
    static let shared = MoviePersistenceManager()
        
    func createMovie(_ movie: Movie) {
        self.newEntity().fromObject(movie)
        self.saveContext()
        print("Movie inserted with id: \(movie.id)")
    }
    
    func movies() -> [Movie]? {
        guard let moviesPersistence = self.fetchData() else { return nil }
        return moviesPersistence.map { Movie(fromPersistence: $0) }
    }
    
    func movie(id: Int) -> Movie? {
        let predicate = NSPredicate(format: "\(#keyPath(MoviePersistence.id)) = %i", id)
        guard let result = self.fetchData(predicate)?.last else { return nil }
        return Movie(fromPersistence: result)
    }
    
    func moviePersistence(id: Int) -> MoviePersistence? {
        let predicate = NSPredicate(format: "\(#keyPath(MoviePersistence.id)) = %i", id)
        guard let result = self.fetchData(predicate)?.last else { return nil }
        return result
    }
    
    func deleteMovie(id: Int) {
        guard let movie = self.moviePersistence(id: id) else { return }
        self.delete(movie)
        print("Movie deleted with id: \(id)")
    }
    
}
