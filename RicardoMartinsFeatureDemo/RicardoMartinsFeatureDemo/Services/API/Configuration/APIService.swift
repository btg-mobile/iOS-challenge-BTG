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
            return "Erro desconhecido."
        case .invalidJson:
            return "Json inválido."
        case .decodeObject:
            return "Erro ao realializar o parse."
        case .invalidResponse:
            return "Response inválido."
        case .server(let error):
            return error.status_message
        }
    }
}

