//
//  MovieManager.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Alamofire

class MovieManager {
    static func getListMovies(section: SectionInfoEnum?, query:String?, page: Int, completion: @escaping (Swift.Result<APIResultList<Movie>, APIError>) -> ()){
        
        var route:APIEndpointible
        
        if let query = query, !query.isEmpty{
            route = MovieEndpoint.search(query: query, page: page)
        }else if let section = section{
            route = MovieEndpoint.list(section: section, page: page)
        }else{
            route = MovieEndpoint.list(section: .popular, page: page)
        }
        
        APIService.shared.performRequest(route: route) { (response) in
            guard let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) else {
                return completion(.failure(.invalidResponse))
            }
            
            guard let json = utf8Text.data(using: .utf8) else {
                return completion(.failure(.invalidJson))
            }
            
            if response?.error != nil {
                do{
                    let error = try JSONDecoder().decode(APIServerError.self, from: json)
                    completion(.failure(.server(error: error)))
                }catch{
                    completion(.failure(.unknown))
                }
            }else{
                do{
                    let data = try JSONDecoder().decode(APIResultList<Movie>.self, from: json)
                    completion(.success(data))
                }catch{
                    completion(.failure(.decodeObject))
                }
            }
        }
    }
    
    static func getListGenres(completion: @escaping (Swift.Result<[MovieGenre], APIError>) -> ()){
        APIService.shared.performRequest(route: MovieEndpoint.genre) { (response) in
            guard let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) else {
                return completion(.failure(.invalidResponse))
            }
            
            guard let json = utf8Text.data(using: .utf8) else {
                return completion(.failure(.invalidJson))
            }
            
            if response?.error != nil {
                do{
                    let error = try JSONDecoder().decode(APIServerError.self, from: json)
                    completion(.failure(.server(error: error)))
                }catch{
                    completion(.failure(.unknown))
                }
            }else{
                do{
                    let data = try JSONDecoder().decode(APIListGenres.self, from: json)
                    completion(.success(data.genres))
                }catch{
                    completion(.failure(.decodeObject))
                }
            }
        }
    }
}
