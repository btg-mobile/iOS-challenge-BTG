//
//  MovieFavoriteModel.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 19/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import Foundation
import UIKit

protocol MovieFavoriteModelDelegate {
    func getFavorite(_ parameters: [String: Any])
    func getImage(path: String, movie: Movie)
    var movieListeDelegate: MovieFavoriteViewController! { get set }
}

class MovieFavoriteModel: MovieFavoriteModelDelegate {
    
    internal var movieListeDelegate: MovieFavoriteViewController!
    
    func getFavorite(_ parameters: [String : Any]) {
        print(parameters)
        movieListeDelegate.business.request(parameters, type: .favorite)
    }
    
    func getImage(path: String, movie: Movie) {
        movieListeDelegate.business.request(URLComplement: path, outData: movie, type: .image)
    }
    
}
