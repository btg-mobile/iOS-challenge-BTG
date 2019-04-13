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
    var favoriteHandler: (() -> Void)?
    
    func setup(movie: MoviesResult, favoriteHandler: @escaping () -> Void) {
        self.favoriteHandler = favoriteHandler
        self.posterImageView.kf.indicatorType = IndicatorType.activity
        self.posterImageView.kf.setImage(with: URL(string: K.ApiServer.Poster(path: movie.posterPath))!)
        self.titleLabel.text = movie.title
        self.ageLabel.text = String(movie.releaseDate.prefix(4))
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        favoriteHandler?()
    }
}
