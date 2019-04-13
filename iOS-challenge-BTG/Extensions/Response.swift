//
//  Response.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 13/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Moya

extension Response {
    func result<T: Decodable>(type: T.Type) -> Result<T,ApiError> {
        guard let response = try? self.filterSuccessfulStatusAndRedirectCodes() else {
            return self.statusCode == 401 ? Result.failure(ApiError.unauthorized) : Result.failure(ApiError.unknown)
        }
        
        guard let result = try? JSONDecoder().decode(type, from: response.data) else {
            return Result.failure(ApiError.invalidResponse)
        }
        
        return Result.success(result)
    }
}
