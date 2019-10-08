//
//  MovieEndpoint.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Alamofire

enum MovieEndpoint: APIEndpointible {
    case list (page: Int)
    case search(query: String, page: Int)
    case genre
    
    var method: HTTPMethod {
        switch self {
        case .list, .search, .genre:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .list(let page):
            return "/movie/popular?api_key=\(Constants.API.key)&language=\(Constants.currentLanguage.rawValue)&page=\(page)"
        case .search(let query, let page):
            return "/search/movie?api_key=\(Constants.API.key)&language=\(Constants.currentLanguage.rawValue)&page=\(page)&query=\(query.replacingOccurrences(of: " ", with: "+"))"
        case .genre:
            return "/genre/movie/list?api_key=\(Constants.API.key)&language=\(Constants.currentLanguage.rawValue)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .list, .search, .genre:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = Constants.API.baseApiURL + path
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentTypeEnum.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldEnum.acceptType.rawValue)
        urlRequest.setValue(ContentTypeEnum.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldEnum.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
