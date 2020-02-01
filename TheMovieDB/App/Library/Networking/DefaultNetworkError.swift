//
//  DefaultError.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import Moya
import RxSwift

func networkErrorHandler<T>(_ error: Error) throws -> Single<T> {
    guard let moyaError = error as? MoyaError else { throw error }
    if case let .statusCode(response) = moyaError, response.statusCode == 401 {
        throw error
    } else {
        throw error
    }
}
