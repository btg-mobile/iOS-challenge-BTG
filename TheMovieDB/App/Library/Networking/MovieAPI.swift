//
//  MovieAPI.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import Moya

enum MovieAPI {
    case getMovies(page: Int)
    case getGenres
}

extension MovieAPI: TargetType {

    var baseURL: URL {
        return URL(string: EnviromentURL.movieURL.baseURL)!
    }

    var path: String {
        switch self {
        case .getMovies:
            return "/movie/popular"
        case .getGenres:
            return "/genre/movie/list"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getMovies(let page):
            return .requestParameters(parameters: ["api_key": EnviromentURL.movieURL.apiKey , "language": "pt-BR", "page": page], encoding: URLEncoding.default)
        case .getGenres:
            return .requestParameters(parameters: ["api_key": EnviromentURL.movieURL.apiKey], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
