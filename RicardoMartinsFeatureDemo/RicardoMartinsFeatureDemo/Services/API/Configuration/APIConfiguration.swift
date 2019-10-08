//
//  APIConfiguration.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Alamofire

protocol APIEndpointible: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum HTTPHeaderFieldEnum: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentTypeEnum: String {
    case json = "application/json"
}

enum APIResourceEnum {
    case image(path: String?, size:APIResourceEnum.Size)
    
    enum Size {
        case w200, w300, w400, w500, original
    }
    
    var url: URL? {
        switch self {
        case .image(let path, let size):
            if let path = path, let url = URL(string: "\(Constants.API.baseImageURL)/\(size)\(path)") {
                return url
            }else{
                return nil
            }
        }
    }
}

