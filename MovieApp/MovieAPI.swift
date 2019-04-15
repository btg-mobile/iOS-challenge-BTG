//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import Foundation
import Alamofire

class MovieAPI: MoviesProtocol {
    
    typealias MovieDefaultCompletion = ([Movie], MovieError?) -> Void
    let movieUrl = MovieURL.popularURL + MovieKeys.apiKey
    var movies = [Movie]()
  
    func getPopularMovies(completion: @escaping MovieDefaultCompletion) {
        Alamofire.request(movieUrl, method: HTTPMethod.get).responseJSON { response in
            
            let result = response.result
            let error = response.error
            print(result.value as Any)
            print(error as Any)
            
            let handledError = handleMovieError(with: response.response!.statusCode)
            guard let data = response.data else { return }
            
            switch handledError {
            case .success:
                self.decodeMovies(with: data)
                completion(self.movies, nil)
          
            case .failure(.noInternet):
                completion(self.movies, MovieError.noInternet)
            case .failure(.notFound):
                completion(self.movies, MovieError.notFound)
            case .failure(.badRequest):
                completion(self.movies, MovieError.notFound)
            case .failure(.internalServerError):
                completion(self.movies, MovieError.internalServerError)
            case .failure(.unknownError):
                completion(self.movies, MovieError.unknownError)
            }
        }
    }
    
    func getPopularMoviesWithPaging(page: Int, completion: @escaping MovieDefaultCompletion) {
        let movieURLUsingPages = movieUrl + "&page=\(page)"
        Alamofire.request(movieURLUsingPages, method: HTTPMethod.get).responseJSON { response in
            
            let handledError = handleMovieError(with: response.response!.statusCode)
            guard let data = response.data else { return }
            
            switch handledError {
            case .success:
                self.decodeMovies(with: data)
                completion(self.movies, nil)
                
            case .failure(.noInternet):
                completion(self.movies, MovieError.noInternet)
            case .failure(.notFound):
                completion(self.movies, MovieError.notFound)
            case .failure(.badRequest):
                completion(self.movies, MovieError.notFound)
            case .failure(.internalServerError):
                completion(self.movies, MovieError.internalServerError)
            case .failure(.unknownError):
                completion(self.movies, MovieError.unknownError)
            }
        }
    }
    
    func decodeMovies(with data: Data)  {
        let decoder = JSONDecoder()
        var moviesDecoded = [Movie]()
        do {
            let result = try decoder.decode(Result.self, from: data)
            moviesDecoded = result.results
        } catch {
            print("Unable to decode Movie - \(error.localizedDescription)")
        }
         movies = moviesDecoded
    }
    
   
}





