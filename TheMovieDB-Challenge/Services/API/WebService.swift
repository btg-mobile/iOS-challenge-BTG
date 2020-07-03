//
//  MovieDataProvider.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

typealias ResultResponse<T> = (_ value: T?, _ success: Bool, _ error : Constants.errorTypes?) -> Void

struct WebService {
    
    static let shared = WebService()
    
    let language: Constants.language = .English //Replace by UserDefaults
    
    enum Endpoints {
        case getMovies
        case getSeries
        case getGenres
        
        var path: String {
            switch self {
            case .getMovies:
                return "\(Constants.API.baseURL)/movie/"
            case .getSeries:
                return "\(Constants.API.baseURL)/series/"
            case .getGenres:
                return "\(Constants.API.baseURL)/genre/"
            }
            
        }
        
    }
    
    func getMovies(page: Int, category: Constants.category, movieSelection: Constants.MovieSelection, completion : @escaping ResultResponse<[Movie]>) {
        
        let resourceString = URL(string: "\(Endpoints.getMovies.path)\(movieSelection.rawValue)?api_key=\(Constants.API.privateKey)&language=\(language.rawValue)&page=\(page)")
        
        guard let resourceURL = resourceString else {fatalError("Problema ao obter os dados")}
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, res, err) in
            
            guard let jsonData = data else {
                completion([], false, .NoDataAvailable)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieHeader = try decoder.decode(MovieHeader.self, from: jsonData)
                if let movieResults = movieHeader.results {
                    
                    let container = MovieContainer(category: category, type: movieSelection, header: movieHeader)
                    
                    completion(movieResults, true, .NoError)
                    
                    if page == 1 {
                        
                        //Pass the number of Pages
                        //self.delegate?.getTotalPages(movieHeader.totalPages ?? 0)
                        
                    }
                    
                    print(String.init(repeating: "-", count: 56) + "API LOG" + String.init(repeating: "-", count: 57))
                    print("Page#\(page) \(resourceURL)")
                    print(String.init(repeating: "-", count: 120));print("")
                    
                }
            }catch {
                
                completion([], false, .CanNotProccessData)
                
            }
            
        }
        
        dataTask.resume()
        
    }
    
    //MARK: - Genre id request
     
     func getGenreIds(completion: @escaping(Genre) -> Void) {
         
         let resourceURL = "\(Constants.API.baseURL)\(Constants.category.Genre.rawValue)/movie/list?api_key=\(Constants.API.privateKey)&language=\(language)"
         
         guard let url = URL(string: resourceURL) else { return }
         
         URLSession.shared.dataTask(with: url) { (data, response, err) in
             
             guard let jsonData = data else {
                 return
             }
             
             do {
                 
                 let genres = try JSONDecoder().decode(Genre.self, from: jsonData)
                 
                 completion(genres)
                 
             }catch {
                 print("Erro ao obter Generos")
             }
             
         }.resume()
         
     }
    
}
