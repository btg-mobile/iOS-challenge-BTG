//
//  MovieDetailViewController.swift
//  BTGTest
//
//  Created by Mario de Castro on 08/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var detailScrollView: UIScrollView!

    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var ratingValueLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!

    @IBOutlet private weak var favoriteButton: UIButton!

    @IBOutlet private weak var genreActivityIndicator: UIActivityIndicatorView!


    private var viewModel: MovieDetailViewInput!

    convenience init(movie: Movie) {
        self.init()

        modalPresentationStyle = .fullScreen

        viewModel = MovieDetailViewModel(view: self, movie: movie)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadDetails()
        setupButtonLayout()
    }

    func setupButtonLayout() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height / 2
        favoriteButton.setTitle("FAVORITE_BUTTON".localized.uppercased(), for: .normal)
    }

    @IBAction private func didPressCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func didPressFavoriteButton(_ sender: Any) {
    }


}

extension MovieDetailViewController: MovieDetailViewOutput {
    func fill(with movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseYear
        overviewLabel.text = movie.overview
        ratingValueLabel.text = "\(movie.voteAverage)"

        backdropImageView.setImageFromURL(movie.backdropURL)
        posterImageView.setImageFromURL(movie.largePosterURL)
    }

    func fillGenres(_ genres: String) {
        genreActivityIndicator.stopAnimating()
        genreLabel.isHidden = false
        genreLabel.text = genres.uppercased()
    }

    func setDetailsLoading() {
        genreLabel.isHidden = true
        genreActivityIndicator.startAnimating()
    }
}
