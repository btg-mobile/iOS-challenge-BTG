//
//  MoviesModels.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Movies {
    struct Request {
        var page: Int
    }
    struct Response {
        var moviesResponse: MoviesResponse? = nil
        var errorMessage: String? = nil
    }
    struct ViewModel {
        var movies: MoviesResponse? = nil
        var errorMessage: String? = nil
    }
}
