//
//  MovieDetailContracts.swift
//  BTGTest
//
//  Created by Mario de Castro on 08/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

// MARK: - MovieDetail View Contracts
protocol MovieDetailViewOutput: class {
    func fill(with movie: Movie)
    func fillGenres(_ genres: String)

    func setDetailsLoading()
}

protocol MovieDetailViewInput {
    func loadDetails()
}
