//
//  MovieDetailEndpoint.swift
//  BTGTest
//
//  Created by Mario de Castro on 08/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieDetailEndpoint: Endpoint {
    init(movieID: Int) {
        let urlPath = URLPath(
            baseURLType: .movieDB,
            path: "/movie/\(movieID)")

        let params = [
            "api_key": Bundle.infoDictionaryValue(forKey: "MovieDBAPIKey"),
            "language": Locale.current.languageCode ?? "pt"
        ]

        super.init(path: urlPath, method: .get, parameters: params)
    }

    func makeRequest(completion: @escaping (DetailResponse?, EndpointError?) -> ()) {
        super.makeRequest(success: { response in
            guard let json = response as? [String: Any],
                let details = DetailResponse(map: Map(mappingType: .fromJSON, JSON: json)) else {
                print("JSON parse error")
                completion(nil, EndpointError.unkown())
                return
            }

            completion(details, nil)
        }, failure: { error in
            completion(nil, error)
        })
    }
}

class DetailResponse: Mappable {
    var genres: [GenreResponse] = []

    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        genres <- map["genres"]
    }
}

class GenreResponse: Mappable {
    var id: Int = 0
    var name: String = ""

    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        id   <- map["id"]
        name <- map["name"]
    }
}
