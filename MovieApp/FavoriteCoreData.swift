//
//  FavoriteCoreData.swift
//  MovieApp
//
//  Created by Lucas Moraes on 12/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit
import CoreData

class FavoriteCoreData {
    
    private init() {}
    
    typealias FavoriteMovieDefaultCompletion = (Error?) -> Void
    private static let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()

    let fileManager = FileManager.default
    var filePath: URL!
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error (PersistentContainer) \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func getFavoriteMovies() -> [FavoriteMovie] {
        var data = [FavoriteMovie]()
        do {
            let favoriteMovies = try context.fetch(fetchRequest)
            data = handleRetrivedData(with: favoriteMovies)
        } catch {
            print("Error on getFavoriteMovies - \(error.localizedDescription)")
        }
        return data
    }
    
    static func saveFavorite(movie: Movie, thumb: UIImage, completion: @escaping FavoriteMovieDefaultCompletion) {
        let favoriteMovie = FavoriteMovie(context: context)
        let context = persistentContainer.viewContext
        var favoriteError: Error?
        
        favoriteMovie.title = movie.title
        favoriteMovie.descrip = movie.description
        favoriteMovie.rate = movie.rate
        favoriteMovie.date = movie.date
        favoriteMovie.image = thumb
        
        do {
            try context.save()
            completion(favoriteError)
        } catch {
            favoriteError = error
            completion(favoriteError)
        }
    }
    
    static func deleteFavorite(favoriteMovie: FavoriteMovie, completion: @escaping FavoriteMovieDefaultCompletion) {
        var favoriteError: Error?
        FavoriteCoreData.context.delete(favoriteMovie)
        
        do {
            try FavoriteCoreData.context.save()
            completion(favoriteError)
        } catch {
            favoriteError = error
            completion(favoriteError)
        }
    }
    
    static func deleteFavorite(usingMovie movie: Movie, completion: @escaping FavoriteMovieDefaultCompletion) {
        
        let namePredicate = NSPredicate(format: "title = @%", movie.title)
        var favoriteError: Error?
        FavoriteCoreData.fetchRequest.predicate = namePredicate

        do {
            let favoriteMovieToDelete = try FavoriteCoreData.context.fetch(FavoriteCoreData.fetchRequest)
            FavoriteCoreData.context.delete(favoriteMovieToDelete.first!)
            try FavoriteCoreData.context.save()
        } catch {
            favoriteError = error
        }
        FavoriteCoreData.fetchRequest.predicate = nil
        completion(favoriteError)
    }
    
    static func checkIfExists(with title: String) -> Bool {
        var data = [FavoriteMovie]()
        do {
            let favoriteMovies = try context.fetch(fetchRequest)
            data = handleRetrivedData(with: favoriteMovies)
            for i in 0..<data.count {
                if data[i].title == title { return true }
            }
        } catch {
            print("Error on getFavoriteMovies - \(error.localizedDescription)")
        }
        return false
    }
    
    private static func handleRetrivedData(with retrivedData:[FavoriteMovie]) -> [FavoriteMovie] {
        return retrivedData.filter { (value) -> Bool in
            value.title != nil
        }
    }
}
