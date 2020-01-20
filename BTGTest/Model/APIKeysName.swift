//
//  APIKeysName.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 11/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import Foundation

enum APIRequest: String{
    case pupular = "https://api.themoviedb.org/3/movie/popular"
    case genres = "https://api.themoviedb.org/3/genre/movie/list"
    case key = "6dc0bb182ed4e5604298e281881ee764"
    case sessionID = "c98f266cda89c3e961a204fb1d012621687d2614"
}

enum APIQuery: String{
    case key = "api_key"
    case language = "language"
    case movieID = "movie_id"
    case sessionID = "session_id"
    case query = "query"
    case page = "page"
}

enum APILenguages: String{
    case english = "en-US"
    case portuguese = "pt-BR"
}
