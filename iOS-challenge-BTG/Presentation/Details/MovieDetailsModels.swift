//
//  MovieDetailsModels.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

import UIKit

enum MovieDetails {
    struct Request {
    }
    struct Response {
        struct MovieDetails : Decodable {
            let genres : [Genre]
            let id : Int
            let overview : String
            let posterPath : String
            let title : String
            let voteAverage : Float
            
            enum CodingKeys: String, CodingKey {
                case genres = "genres"
                case id = "id"
                case overview = "overview"
                case posterPath = "poster_path"
                case title = "title"
                case voteAverage = "vote_average"
            }
        }
        
        struct Genre : Decodable {
            let id : Int
            let name : String
            
            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
            }
        }
    }
    struct ViewModel {
    }
}
