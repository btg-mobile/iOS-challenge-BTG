//
//  MovieListBussiness.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 12/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListModelDelegate {
    func getPopular(_ parameters: [String: Any])
    func getImage(path: String, movie: Movie)
    func getSearch(_ parameters: [String: Any])
    var movieListeDelegate: MovieListViewController! { get set }
}

class MovieListModel: MovieListModelDelegate{
    
    internal var movieListeDelegate: MovieListViewController!
    
    internal func getPopular(_ parameters: [String: Any]) {
        movieListeDelegate.business.request(parameters, type: .pupular)
    }
    
    internal func getImage(path: String, movie: Movie) {
        movieListeDelegate.business.request(URLComplement: path, outData: movie, type: .image)
    }
    
    internal func getSimilar(_ parameters: [String: Any]) {
        movieListeDelegate.business.request(parameters, type: .similar)
    }
    
    internal func getSearch(_ parameters: [String: Any]) {
        movieListeDelegate.business.request(parameters, type: .search)
    }
    
}





