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
    func fillTitle(_ title: String)
    func fillYear(_ year: String)
    func fillOverview(_ overview: String)
    func fillRating(_ rating: String)
    func fillGenres(_ genres: String)
    func setPosterImage(with url: URL?)
    func setBackdropImageURL(with url: URL?)

    func updateFavoriteButton(title: String, highlighted: Bool)

    func setDetailsLoading()
}

protocol MovieDetailViewInput {
    func loadDetails()

    func toggleFavorite()
}
