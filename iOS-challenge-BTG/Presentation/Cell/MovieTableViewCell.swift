//
//  MovieTableViewCell.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 13/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    private var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(UIImage(named: self.isFavorite ? "star_filled" : "star"), for: .normal)
        }
    }
    private var favoriteHandler: ((Bool) -> Void)?
    
    func setup(movie: MoviesResult, isFavorite: Bool, favoriteHandler: @escaping (Bool) -> Void) {
        self.favoriteHandler = favoriteHandler
        self.isFavorite = isFavorite
        self.posterImageView.kf.indicatorType = IndicatorType.activity
        self.posterImageView.kf.setImage(with: URL(string: K.ApiServer.Poster(path: movie.posterPath))!)
        self.titleLabel.text = movie.title
        self.ageLabel.text = String(movie.releaseDate.prefix(4))
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        self.isFavorite = !self.isFavorite
        favoriteHandler?(self.isFavorite)
    }
}
