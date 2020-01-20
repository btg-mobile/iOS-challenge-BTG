//
//  MovieService.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation

class MovieService {

    // MARK: - Requests

    func fetchPopularMovies(with
        page: Int,
        completion: @escaping (MovieViewModel?, MovieServiceError?) -> ()) {

        let path = "/movie/popular"

        guard let url = URL(string: "\(createApiUrl(with: path))&page=\(page)") else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(MovieViewModel.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetch())
            }
        }).resume()
    }

    func fetchMovie(with
        id: Int,
        completion: @escaping (Movie?, MovieServiceError?) -> ()) {

        let path = "/movie/\(id)"

        guard let url = URL(string: createApiUrl(with: path)) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetchMovie())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetchMovie())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(Movie.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetchMovie())
            }
        }).resume()
    }

    // MARK: - Utility

    private func createApiUrl(with path: String) -> String {
        return "\(Constants.api().url)\(path)?api_key=\(Constants.api().key)&language=\(Constants.api().language)"
    }
}

// MARK: - Request errors

enum MovieServiceError: Equatable, Error {
    case CannotFetch(String = "Não foi possível obter a lista de filmes. " +
                              "Por favor, verifique a sua conexão com a internet.")
    case CannotFetchMovie(String = "Não foi possível obter o filme. " +
                                   "Por favor, verifique a sua conexão com a internet.")
}
