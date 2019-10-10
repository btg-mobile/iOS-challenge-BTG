//
//  MovieListTableViewCell.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var favouriteButton: UIButton!

    var didPressFavorite: (() -> Void)!
    var favorited = false

    func fill(movie: Movie, showFavouriteButton: Bool = true) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseYear

        posterImageView.setImageFromURL(movie.smallPosterURL)

        favouriteButton.isHidden = !showFavouriteButton
    }

    func setFavourite(_ favourite: Bool, animated: Bool = false) {
        favorited = favourite
        UIView.animate(withDuration: animated ? 0.1 : 0.0) {
            if favourite {
                self.favouriteButton.tintColor = .systemOrange
                self.favouriteButton.setImage(UIImage(named: "starFilled"), for: .normal)
            } else {
                if #available(iOS 13.0, *) {
                    self.favouriteButton.tintColor = .secondaryLabel
                } else {
                    self.favouriteButton.tintColor = .gray
                }
                self.favouriteButton.setImage(UIImage(named: "starOutline"), for: .normal)
            }
        }
    }

    @IBAction private func didPressFavouriteButton(_ sender: Any) {
        setFavourite(!favorited, animated: true)
        didPressFavorite()
    }

}
