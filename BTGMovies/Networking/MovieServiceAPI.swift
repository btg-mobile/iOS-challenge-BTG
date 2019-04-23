//
//  MovieServiceAPI.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class MovieServiceAPI {
    
    // MARK: - Constants
    public static let shared = MovieServiceAPI()
    private init() {}
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    
    // MARK: - Endpoint
    enum Endpoint: String {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
    }
    
    func fetchMovies(from endpoint: Endpoint, completion: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        RequestManager.fetchResources(url: movieURL, completion: completion)
    }
        
    func getImage(path: String, completion: @escaping (Result<UIImage, APIServiceError>) -> Void) {
        let url = URL(string: "https://image.tmdb.org")!
            .appendingPathComponent("t/p/w500")
            .appendingPathComponent(path)
        RequestManager.getImage(url: url, completion: completion)
    }
}
