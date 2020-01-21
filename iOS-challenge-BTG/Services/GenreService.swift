//
//  GenreService.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation

struct Genres: Codable {
    var genres: [Genre] = []
}

class GenreService: Service {

    // MARK: - Requests

    func fetchGenres(with
        completion: @escaping ([Genre]?, GenreServiceError?) -> ()) {

        let path = "/genre/movie/list"

        guard let url = createApiUrl(with: path, queryItems: []) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, GenreServiceError.CannotFetch())
                    return
                }
                guard let data = data else {
                    completion(nil, GenreServiceError.CannotFetch())
                    return
                }

                let result = try JSONDecoder().decode(Genres.self, from: data)
                completion(result.genres, nil)
            } catch {
                completion(nil, GenreServiceError.CannotFetch())
            }
        }).resume()
    }
}

// MARK: - Request errors

enum GenreServiceError: Equatable, Error {
  case CannotFetch(String = "Não foi possível obter a lista de gêneros. " +
                            "Por favor, verifique a sua conexão com a internet.")
}
