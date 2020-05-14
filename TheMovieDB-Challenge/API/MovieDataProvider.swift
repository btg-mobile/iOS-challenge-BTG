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

fileprivate let resourceString = "\(Constants.API.baseURL)\(Constants.MovieSelection.nowPlaying.rawValue)?api_key=\(Constants.API.privateKey)&language=\(Constants.language.portuguese.rawValue)&page=1"

var genreArray : [String] = []

class MovieDataProvider {
    
    weak var delegate : MovieDataProviderDelegate?
    var page: Int?
    
    //MARK: - Movie request
    
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
    
    
    //MARK: - Genre id request
    
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
    
}
