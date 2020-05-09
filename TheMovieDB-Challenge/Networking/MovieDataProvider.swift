//
//  MovieDataProvider.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

protocol MovieDataProviderDelegate : class {
    
    func successOnLoading(movies: [Movie]?)
    func errorOnLoading(error: Error?)
    
}

enum MovieSelection : String {
    
    case popular = "popular"
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    
}

enum language : String {
    
    case portuguese = "pt-BR"
    case english = "en-US"
    case spanish = "es-ES"
    
}

fileprivate let BASE_URL = "https://api.themoviedb.org/3/movie/"
fileprivate let API_KEY = "132dfc8e68a337152fd3e36d63c77677"

fileprivate let resourceString = "\(BASE_URL)\(MovieSelection.nowPlaying.rawValue)?api_key=\(API_KEY)&language=\(language.portuguese.rawValue)&page=1"

var genreArray : [String] = []

class MovieDataProvider {
    
    weak var delegate : MovieDataProviderDelegate?
    
    func getGenreIds(completion: @escaping(Genre) -> Void) {
        
        let resourceURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=132dfc8e68a337152fd3e36d63c77677&language=pt-BR"
        
        guard let url = URL(string: resourceURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let jsonData = data else {
                return
            }
            
            do {
                
                let genres = try JSONDecoder().decode(Genre.self, from: jsonData)
                
                completion(genres)
                
            }catch{
                print("Erro ao obter Generos")
            }
            
        }.resume()
        
    }
    
    enum MovieError: Error {
        case noDataAvailable
        case canNotProccessData
    }
    
    func getPopularMovies (completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        
        guard let resourceURL = URL(string: resourceString) else {fatalError("Problema ao obter os dados")}
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, res, err) in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                self.delegate?.errorOnLoading(error: err)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieHeader = try decoder.decode(MovieHeader.self, from: jsonData)
                if let movieResults = movieHeader.results {
                    self.delegate?.successOnLoading(movies: movieResults)
                    completion(.success(movieResults))
                    
                }
            }catch{
                self.delegate?.errorOnLoading(error: error)
                completion(.failure(.canNotProccessData))
            }
            
        }
        
        dataTask.resume()
        
    }
    
}
