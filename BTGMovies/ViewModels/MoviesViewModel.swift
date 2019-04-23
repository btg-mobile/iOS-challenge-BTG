//
//  MoviesViewModel.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

class MoviesViewModel {

    enum ScreenType {
        case popular
        case favorites
    }
    
    init(screenType: ScreenType) {
        self.screenType = screenType
    }
    
    private var movies = [MovieViewModel]()
    private var filteredMovies = [MovieViewModel]()
    let screenType: ScreenType
    
    // MARK: - API
    func getMovies(completion: @escaping (Bool) -> Void) {
        MovieServiceAPI.shared.fetchMovies(from: .popular) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results.map { MovieViewModel($0) }
                self.filteredMovies = self.movies
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return filteredMovies.count
    }
    
    func movie(at index: Int) -> MovieViewModel {
        return filteredMovies[index]
    }
    
    func filterMovies(text: String) {
        if text.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.title.localizedCaseInsensitiveContains(text) }
        }
    }
}

// MARK: - CoreData

extension MoviesViewModel {
    func initWithPersistence() {
        guard let movies = MoviePersistenceManager.shared.movies() else {
            return
        }
        self.movies = movies.map { MovieViewModel($0) }
        self.filteredMovies = self.movies
    }
    
    func saveMovie(at index: Int) {
        MoviePersistenceManager.shared.createMovie(filteredMovies[index].movie)
    }
    
    func removeMovie(at index: Int) {
        let movie = filteredMovies[index].movie
        if case .favorites = self.screenType {
            filteredMovies.removeAll(where: { $0.movie.id == movie.id })
            movies.removeAll(where: { $0.movie.id == movie.id })
        }
        MoviePersistenceManager.shared.deleteMovie(id: movie.id)
    }
    
    func isFavorite(at index: Int) -> Bool {
        let movie = filteredMovies[index].movie
        return MoviePersistenceManager.shared.movie(id: movie.id) != nil
    }
}
