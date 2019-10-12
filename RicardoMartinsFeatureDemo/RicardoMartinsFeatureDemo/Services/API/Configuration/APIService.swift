//
//  APIService.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Alamofire

typealias APIServiceResponse = (DataResponse<Any>?) -> ()

class APIService{
    static let shared = APIService()
    
    private init(){}
    
    @discardableResult
    func performRequest(route: APIEndpointible, completion: @escaping APIServiceResponse) -> DataRequest{
        return Alamofire.request(route).validate().responseJSON(completionHandler: completion)
    }
}

struct APIResultList<T:Decodable>:Decodable{
    let results: [T]
    let page: Int
    let total_results: Int
    let total_pages :Int
}

struct APIListGenres:Decodable {
    let genres: [MovieGenre]
}

struct APIServerError:Decodable {
    let status_code: Int
    let status_message: String
}

enum APIError: Error {
    case unknown
    case invalidJson
    case decodeObject
    case invalidResponse
    case server(error:APIServerError)
    
    var code: Int {
        switch self {
        case .server(let error):
            return error.status_code
        default:
            return 0
        }
    }
    
    var description: String {
        switch self {
        case .unknown:
            return String.Localizable.error.getValue(code: 0)
        case .invalidJson:
            return String.Localizable.error.getValue(code: 1)
        case .decodeObject:
            return String.Localizable.error.getValue(code: 2)
        case .invalidResponse:
            return String.Localizable.error.getValue(code: 3)
        case .server(let error):
            return error.status_message
        }
    }
}

