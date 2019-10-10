//
//  SearchMovieEndpoint.swift
//  BTGTest
//
//  Created by Mario de Castro on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchMovieEndpoint: Endpoint {
    init(searchText: String, page: Int) {
        let urlPath = URLPath(
            baseURLType: .movieDB,
            path: "/search/movie")

        let params: [String: Any] = [
            "api_key": Bundle.infoDictionaryValue(forKey: "MovieDBAPIKey"),
            "language": Locale.current.languageCode ?? "pt",
            "region": Locale.current.regionCode ?? "BR",
            "query": searchText,
            "page": page
        ]

        super.init(path: urlPath, method: .get, parameters: params)
    }

    func makeRequest(completion: @escaping (MovieListResponse?, EndpointError?) -> ()) {
        super.makeRequest(success: { response in
            guard let json = response as? [String: Any],
                let movies = MovieListResponse(map: Map(mappingType: .fromJSON, JSON: json)) else {
                print("JSON parse error")
                completion(nil, EndpointError.unkown())
                return
            }

            completion(movies, nil)
        }, failure: { error in
            completion(nil, error)
        })
    }
}
