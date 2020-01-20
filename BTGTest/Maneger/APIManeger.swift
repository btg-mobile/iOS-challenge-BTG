//
//  APIManeger.swift
//  FSMovie
//
//  Created by Magno Augusto Ferreira Ruivo on 12/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

protocol MovieListViewDelegate {
    func obtainData(movies: [Movie])
    func obtainGenres(genres: [Genre])
    func populate(WithImage image: Data, movie: Movie)
    func markFavorite()
}

extension MovieListViewDelegate {
    func markFavorite() {}
    
    func obtainGenres(genres: [Genre]) {}
}

class MovieListManeger{
    
    var delegate: MovieListViewDelegate!
    
    func request(_ parameters: [String: Any]? = nil, URLComplement: String = "", headers: HTTPHeaders? = nil, outData: Any? = nil, type: APIManeger){
        switch type {
        case .pupular, .similar, .favorite, .search:
            type.get(parameters: parameters, URLComplement: URLComplement, completion: { data in
                    do{
                        let movies = try JSONDecoder().decode(Response.self, from: data)
                        DispatchQueue.main.async {
                            guard let mvs = movies.results else{print("Erro ao carregar"); return}
                            self.delegate.obtainData(movies: mvs)
                        }
                    } catch let error {
                        print(error)
                    }
                    
                }, failure: { error in
                    print(error)
                })
            
        case .image:
            type.get(URLComplement: URLComplement, completion: {data in
                DispatchQueue.main.async {
                    self.delegate.populate(WithImage: data, movie: outData as! Movie)
                }

            }, failure: {error in
                print(error)
            })
            
        case .markFavorite:
            type.post(url: URLComplement, parameters: parameters, headers: headers,
                status: { status in
                    self.delegate.markFavorite()
                },
                failure: { failure in
                    print(failure)
            })
            
        case .genre:
            type.get(parameters: parameters, completion: { data in
                do{
                    let genresData = try JSONDecoder().decode(Genres.self, from: data)
                    DispatchQueue.main.async {
                        guard let genres = genresData.genres else {print("Erro ao carregar"); return}
                        self.delegate.obtainGenres(genres: genres)
                    }
                } catch let error {
                    print(error)
                }
                
            }, failure: { error in
                print(error)
            })
        }
    }
}

extension MovieListManeger{
    
    enum APIManeger: String{
        
        case pupular = "https://api.themoviedb.org/3/movie/popular"
        case image = "https://image.tmdb.org/t/p/"
        case similar = "https://api.themoviedb.org/3/movie/"
        case favorite = "https://api.themoviedb.org/3/account/0/favorite/movies"
        case search = "https://api.themoviedb.org/3/search/movie"
        case genre = "https://api.themoviedb.org/3/genre/movie/list"
        
        func get(parameters:[String : Any]? = nil, URLComplement: String = "", completion: @escaping (_ response: Data) -> Void, failure: @escaping (_ error: Error) -> Void) {
            print(self.rawValue + URLComplement)
            AF.request(self.rawValue + URLComplement, parameters: parameters).response { (response) in
                switch response.result{
                case .success:
                    guard response.result.isSuccess, let value = response.data else {
                        print("Error \(String(describing: response.result.error))")
                        return
                    }
                    completion(value)
                    
                case .failure(let error):
                    failure(error)
                    
                }
            }
        }
        
        case markFavorite = "https://api.themoviedb.org/3/account/0/favorite" 
        
        func post(url: String = "", parameters: [String: Any]?, headers: HTTPHeaders?, status: @escaping (_ response: Any) -> Void,
                                failure: @escaping (_ response: Any) -> Void) {
            print(self.rawValue + url)
            AF.request(self.rawValue + url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                    
                case .success(let success):
                    status(success)
                    
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
}

