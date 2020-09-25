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
        static let baseURL = "https://api.themoviedb.org/3"
        static let imageURLBanner = "https://image.tmdb.org/t/p/w1280"
        static let imageURLCover = "https://image.tmdb.org/t/p/original"
        static let publicKey = ""
        static let privateKey = "132dfc8e68a337152fd3e36d63c77677"
    }
    
    enum errorTypes: Error {
        case NoError
        case NoDataAvailable
        case CanNotProccessData
    }
    
    enum MovieSelection : String {
        
        case Popular = "popular"
        case NowPlaying = "now_playing"
        case Upcoming = "upcoming"
        case TopRated = "top_rated"
        case NoSelection
    }
    
    enum language : String {
        
        case Portuguese = "pt-BR"
        case English = "en-US"
        case Spanish = "es-ES"
        
    }
    
    enum category : String {
        
        case Movie = "movie"
        case Series = "serie"
        case Genre = "genre"
        case NoCategory
    }
    
    //GET /movie/{movie_id}/external_ids
    
    enum MovieEndpoint {
        case account_states
        case alternative_titles
        case changes
        case credits
        case external_ids
        case images
        case keywords
        case release_dates
        case videos
        case translations
        case recommendations
        case similar
        case reviews
        case lists
        case rating//POST DELETE
        
    }
    
}
