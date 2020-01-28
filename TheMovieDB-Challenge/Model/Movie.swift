//
//  Movie.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

// MARK: - Movie
struct MovieHeader: Codable {
    let page, totalResults, totalPages: Int?
    let results: [MovieResults]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults
        case totalPages
        case results
    }
}

// MARK: - Result
struct MovieResults: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount
        case video
        case posterPath
        case id, adult
        case backdropPath
        case originalLanguage
        case originalTitle
        case genreIDS
        case title
        case voteAverage
        case overview
        case releaseDate
    }
}

//enum OriginalLanguage: String, Codable {
//    case cn = "cn"
//    case en = "en"
//    case ko = "ko"
//}


//typealias MovieArray = [Result]
