//
//  MovieListCollectionViewCell.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 10/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var favoruteButton: UIButton!

    var didPressFavorite: (() -> Void)!
    var favorited = false

    func fill(movie: Movie, showFavouriteButton: Bool = true) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseYear

        posterImageView.setImageFromURL(movie.largePosterURL)

        favoruteButton.isHidden = !showFavouriteButton
        self.favoruteButton.tintColor = .systemOrange
    }

    func setFavourite(_ favourite: Bool, animated: Bool = false) {
        favorited = favourite
        if favourite {
            self.favoruteButton.setImage(UIImage(named: "starFilled"), for: .normal)
        } else {
            self.favoruteButton.setImage(UIImage(named: "starOutline"), for: .normal)
        }
    }

    @IBAction private func didPressFavoriteButton(_ sender: Any) {
        setFavourite(!favorited, animated: true)
        didPressFavorite()
    }

}
