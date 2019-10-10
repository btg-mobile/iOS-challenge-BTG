//
//  PopularMoviesEndpoint.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import ObjectMapper

class PopularMoviesEndpoint: Endpoint {
    init(page: Int) {
        let urlPath = URLPath(
            baseURLType: .movieDB,
            path: "/movie/popular")

        let params: [String: Any] = [
            "api_key": Bundle.infoDictionaryValue(forKey: "MovieDBAPIKey"),
            "language": Locale.current.languageCode ?? "pt",
            "region": Locale.current.regionCode ?? "BR",
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

class MovieListResponse: Mappable {
    var page: Int = 0
    var totalPages: Int = 0
    var totalResults: Int = 0
    var movies: [Movie] = []

    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        page         <- map["page"]
        totalPages   <- map["total_pages"]
        totalResults <- map["total_results"]
        movies       <- map["results"]
    }
}
