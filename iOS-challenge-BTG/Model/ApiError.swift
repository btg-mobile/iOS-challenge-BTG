//
//  ApiError.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 13/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case unauthorized
    case unknown
    case invalidResponse
    case failure
    case standard(error: Error)
}

extension ApiError {
    var message: String {
        switch self {
        case .unauthorized:
            return "Falha na autorização"
        case .unknown:
            return "Ocorreu um erro desconhecido, por favor, tente novamente!"
        case .invalidResponse:
            return "Ocorreu um erro desconhecido, por favor, tente novamente!"
        case .failure:
            return "Ocorreu uma falha no processo, por favor, tente novamente!"
        case .standard(let error):
            return error.localizedDescription
        }
    }
}
