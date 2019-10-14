//
//  SessionManager.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit
import CoreData

class SessionManager {
    static var shared: SessionManager = SessionManager()
    let service = MoviesService()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var imageConfig: MovieImageConfiguration?
    var genreList: GenreInfo?
    
    init() {
        
    }
    
    func getInfo(success: @escaping ()-> (), failed: @escaping (Error) -> ()) {
        service.getImagesConfiguration(success: { [weak self] (config) in
            guard let self = self else {
                return
            }
            self.imageConfig = config
            self.service.getMoviesGenres(success: { [weak self] (info) in
                guard let self = self else {
                    return
                }
                self.genreList = info
                success()
            }, failed: { (error) in
                print(error)
                failed(error)
            })
            
        }) { (error) in
            print(error)

            failed(error)
        }
    }
    
    func saveMovie(_ movie: Movie) -> Favourite? {
        
        let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: context)
        let favourite = NSManagedObject(entity: entity!, insertInto: context) as! Favourite
        favourite.posterPath = movie.posterPath
        favourite.movieId = Int64(movie.movieId ?? 0)
        favourite.originalTitle = movie.originalTitle
        if let list = movie.genreIds {
            favourite.genreIds = list.map({
                NSNumber(value:$0)
            })
        }
        favourite.voteAverage = movie.voteAverage ?? 0.0
        favourite.overview = movie.overview
        favourite.releaseDate = movie.releaseDate
        do {
            try context.save()
            
        } catch {
            return nil
        }
        return favourite
    }
    
    func deleteMovie(_ movie: Movie) {
        guard let id = movie.movieId else {
            
            return
        }
        
        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "movieId==\(id)")
        
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        try? context.save()
    }
    
    func getFavourite(_ movie: Movie) -> Favourite? {
        guard let id = movie.movieId else {
            
            return nil
        }
        
        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "movieId==\(id)")
        
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                return object
            }
        }
        return nil
    }
    
    func getAllFavourites() -> [Favourite] {

        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()

        if let result = try? context.fetch(fetchRequest) {
            return result
        }
        return []
    }
}
