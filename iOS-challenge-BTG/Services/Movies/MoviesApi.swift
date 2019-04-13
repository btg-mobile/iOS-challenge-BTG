//
//  MoviesApi.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Moya

enum MoviesApi {
    case popular(page: Int)
    case details(movieId: Int)
}

extension MoviesApi: TargetType {
    var baseURL: URL {
        return URL(string: K.ApiServer.BaseURL)!
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case .details(let movieId):
            return "/3/movie/\(movieId)"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        fatalError()
    }
    
    var task: Task {
        switch self {
        case .popular(let page):
            return .requestParameters(parameters: ["api_key" : K.ApiServer.TheMovieDbKey, "language" : "pt-BR", "page" : page],
                                      encoding: URLEncoding.default)
        case .details:
            return .requestParameters(parameters: ["api_key" : K.ApiServer.TheMovieDbKey, "language" : "pt-BR"],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
}

