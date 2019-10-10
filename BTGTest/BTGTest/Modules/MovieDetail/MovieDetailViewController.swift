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
    @IBOutlet private weak var ratingActivityIndicator: UIActivityIndicatorView!


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
    }

    @IBAction private func didPressCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func didPressFavoriteButton(_ sender: Any) {
        viewModel.toggleFavorite()
    }


}

extension MovieDetailViewController: MovieDetailViewOutput {
    func fillTitle(_ title: String) {
        titleLabel.text = title
    }

    func fillYear(_ year: String) {
        yearLabel.text = year
    }

    func fillOverview(_ overview: String) {
        overviewLabel.text = overview
    }

    func fillRating(_ rating: String) {
        ratingActivityIndicator.stopAnimating()
        ratingValueLabel.isHidden = false
        ratingValueLabel.text = rating
    }

    func fillGenres(_ genres: String) {
        genreActivityIndicator.stopAnimating()
        genreLabel.isHidden = false
        genreLabel.text = genres.uppercased()
    }

    func setPosterImage(with url: URL?) {
        posterImageView.setImageFromURL(url)
    }

    func setBackdropImageURL(with url: URL?) {
        backdropImageView.setImageFromURL(url)
    }

    func updateFavoriteButton(title: String, highlighted: Bool) {
        favoriteButton.setTitle(title, for: .normal)

        UIView.animate(withDuration: 0.1) {
            if highlighted {
                if #available(iOS 13.0, *) {
                    self.favoriteButton.setTitleColor(.systemBackground, for: .normal)
                } else {
                    self.favoriteButton.setTitleColor(.white, for: .normal)
                }
                self.favoriteButton.layer.borderColor = UIColor.systemOrange.cgColor
                self.favoriteButton.backgroundColor = .systemOrange
                self.favoriteButton.layer.borderWidth = 0
            } else {
                if #available(iOS 13.0, *) {
                    self.favoriteButton.setTitleColor(.secondaryLabel, for: .normal)
                    self.favoriteButton.layer.borderColor = UIColor.secondaryLabel.cgColor
                } else {
                    self.favoriteButton.setTitleColor(.gray, for: .normal)
                    self.favoriteButton.layer.borderColor = UIColor.gray.cgColor
                }
                self.favoriteButton.backgroundColor = .clear
                self.favoriteButton.layer.borderWidth = 2
            }
            self.favoriteButton.layoutIfNeeded()
        }
    }

    func setDetailsLoading() {
        genreLabel.isHidden = true
        ratingValueLabel.isHidden = true
        genreActivityIndicator.startAnimating()
        ratingActivityIndicator.startAnimating()
    }
}
