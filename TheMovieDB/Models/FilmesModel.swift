//
//  FilmesModel.swift
//  TheMovieDB
//
//  Created by Eric Soares Filho on 15/04/19.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit

struct FilmesModel{
    struct Fetch {
        struct Request
        {
            var movieNameSearch: String?
        }
        struct Response
        {
            var id: Int?
            var poster: String?
            var nome: String?
            var ano: String?
            var sinopse: String?
            var avaliacao: Double?
            var generos: [String]?
        }
        struct ViewModel
        {
            var id: Int?
            var poster: String?
            var nome: String?
            var ano: String?
            var sinopse: String?
            var avaliacao: Double?
            var generos: [String]?
        }
    }
}
