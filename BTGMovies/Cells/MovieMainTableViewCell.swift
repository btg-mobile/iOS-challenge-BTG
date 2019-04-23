//
//  MovieMainTableViewCell.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class MovieMainTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    var favoriteTapped: ((Bool) -> Void)?
    
    func setup(movie: MovieViewModel) {
        coverImageView.setImage(path: movie.posterPath)
        backgroundImageView.setImage(path: movie.backdropPath)
        title.text = movie.title
        yearLabel.text = movie.releaseDate
        favoriteButton.setImage(movie.isFavorite ? #imageLiteral(resourceName: "favorite-filled"): #imageLiteral(resourceName: "favorites-tab-icon"), for: .normal)
    }
    
    @IBAction func favoriteButtonTapped(sender: UIButton) {
        let isFavorited = sender.image(for: .normal) == #imageLiteral(resourceName: "favorite-filled")
        sender.setImage(isFavorited ? #imageLiteral(resourceName: "favorites-tab-icon") : #imageLiteral(resourceName: "favorite-filled"), for: .normal)
        favoriteTapped?(!isFavorited)
    }
}
