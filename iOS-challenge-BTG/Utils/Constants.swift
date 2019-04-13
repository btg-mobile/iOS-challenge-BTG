//
//  Constants.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

struct K {
    struct ApiServer {
        static let BaseURL = "https://api.themoviedb.org"
        static let TheMovieDbKey = Bundle.main.object(forInfoDictionaryKey: "TheMovieDB Key") as! String
        static func Poster(path: String) -> String {
            return "https://image.tmdb.org/t/p/original/\(path)"
        }
    }
    struct Messages {
        static let Unknown = "Ocorreu um erro inesperado, por favor, tente novamente mais tarde!"
    }
}
