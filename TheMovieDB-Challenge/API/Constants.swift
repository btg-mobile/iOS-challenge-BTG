//
//  Constants.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 13/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

enum Constants {
    enum API {
        static let baseURL = "https://api.themoviedb.org/3/movie/"
        static let publicKey = ""
        static let privateKey = "132dfc8e68a337152fd3e36d63c77677"
    }
    
    //    enum Dimensions {
    //        static let spacing: CGFloat = 16.0
    //        static let minItemSize = CGSize(width: 200, height: 225)
    //    }
    
    enum MovieSelection : String {
        
        case popular = "popular"
        case nowPlaying = "now_playing"
        case upcoming = "upcoming"
        case topRated = "top_rated"
        
    }
    
    enum language : String {
        
        case portuguese = "pt-BR"
        case english = "en-US"
        case spanish = "es-ES"
        
    }
    
    enum category {
        
        case movie
        case series
        case genre
    }
    
}

enum MovieError: Error {
    case noDataAvailable
    case canNotProccessData
}
