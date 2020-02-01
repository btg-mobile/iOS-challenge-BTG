//
//  MoviesWorker.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import RxSwift
import Moya

struct MoviesWorker {
    
    var provider: MoyaProvider<MovieAPI>

    init(provider: MoyaProvider<MovieAPI> = MoyaProvider()) {
        self.provider = provider
    }
    
    func getMovies(page: Int) -> Single<MoviesResponse> {
        return provider.rx.request(.getMovies(page: page))
            .filter(statusCode: 200)
            .catchError(networkErrorHandler)
            .map(MoviesResponse.self)
    }
    
    func getGenres() -> Single<[Genre]> {
        return provider.rx.request(.getGenres)
            .filter(statusCode: 200)
            .catchError(networkErrorHandler)
            .map([Genre].self)
    }
}
