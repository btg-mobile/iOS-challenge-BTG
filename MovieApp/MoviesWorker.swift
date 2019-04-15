//
//  MoviesWorker.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import Foundation

class MovieWorker {
    
    let movieApi = MovieAPI()
    var movieInteractorProtocol: MovieInteractorLogic?
    
    func downloadPopularMovies(completion: @escaping ([Movie], MovieError?) -> Void) {
        movieApi.getPopularMovies { (movies, movieError) in
            DispatchQueue.main.async {
                completion(movies, movieError)
            }
        }
    }
    
    func downloadPopularMovies(withPage page: Int, completion: @escaping ([Movie], MovieError?) -> Void) {
        movieApi.getPopularMoviesWithPaging(page: page) { (movies, movieError) in
            DispatchQueue.main.async {
                completion(movies, movieError)
            }
        }
    }
}

protocol MoviesProtocol {
    func getPopularMovies(completion: @escaping ([Movie], MovieError?) -> Void)
    func getPopularMoviesWithPaging(page: Int, completion: @escaping ([Movie], MovieError?) -> Void)
}

enum MovieError: String, Error {
    case noInternet = "Sem acesso a internet"
    case notFound = "Resultado não existe"
    case badRequest = "Requisição foi mal exetutada"
    case internalServerError = "Erro no servidor"
    case unknownError = "Erro descolhecido"
}

enum ResultType {
    case success
    case failure(MovieError)
}

func handleMovieError(with statusCode: Int) -> ResultType {
    switch statusCode {
    case 200:
        return ResultType.success
    case 400:
        return ResultType.failure(MovieError.badRequest)
    case 404:
        return ResultType.failure(MovieError.notFound)
    case 500:
        return ResultType.failure(MovieError.internalServerError)
    default:
        return ResultType.failure(MovieError.unknownError)
    }
}

