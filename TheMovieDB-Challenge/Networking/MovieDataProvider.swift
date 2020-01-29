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

fileprivate let BASE_URL = "https://api.themoviedb.org/3/movie/popular?api_key="
fileprivate let API_KEY = "132dfc8e68a337152fd3e36d63c77677"
let LANGUAGE = "pt-BR"
fileprivate let resourceString = "\(BASE_URL)\(API_KEY)&language=\(LANGUAGE)&page=1"

class MovieDataProvider {

    weak var delegate : MovieDataProviderDelegate?
    
    enum MovieError: Error{
        case noDataAvailable
        case canNotProccessData
    }
    
    func getPopularMovies (completion: @escaping(Result<[Movie], MovieError>) -> Void) {
    
        guard let resourceURL = URL(string: resourceString) else {fatalError("Problema ao obter os dados")}
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, res, err) in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
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
