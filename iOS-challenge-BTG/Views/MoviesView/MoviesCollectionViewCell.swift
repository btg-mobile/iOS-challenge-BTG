//
//  MoviesCollectionViewCell.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 17/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var posterImage: CustomImageView!

    // MARK: - Object lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 2
    }

    // MARK: - Setup

    func setupCell(with movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseYear
        posterImage.loadImageUsing(path: movie.smallPosterPath)
    }
}
