//
//  ShowMovieViewController.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

class ShowMovieViewController: UIViewController {

    private var viewModel = ShowMovieViewModel()

    @IBOutlet private weak var posterImageView: CustomImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var voteAvarageLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    // MARK: - Object lifecycle

    init(with movie: Movie, isFavorite: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        viewModel.movie = movie
        viewModel.isFavorite = isFavorite
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup

    private func setup() {
        navigationItem.largeTitleDisplayMode = .never
        checkFavorite()
        checkGenres()
        fillContent()
    }

    private func checkGenres() {
        self.genresLabel.text = ""
        if viewModel.movie.genres == nil {
            fetchMovie()
        } else {
            displayGenres()
        }
    }

    private func fillContent() {
        posterImageView.loadImageUsing(path: viewModel.movie.largePosterPath)
        titleLabel.text = viewModel.movie.title
        releaseDateLabel.text = viewModel.movie.formatedReleaseDate
        voteAvarageLabel.text = "Nota \(viewModel.movie.voteAverage ?? 0.0)"
        overviewLabel.text = viewModel.movie.overview
    }

    private func checkFavorite() {
        viewModel.checkFavorite { (movie) in
            DispatchQueue.main.async {
                self.createFavoriteButton()
            }
        }
    }

    private func createFavoriteButton() {
        let image = viewModel.isFavorite ? UIImage(named: "icon-star-full") : UIImage(named: "icon-star")
        let button = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(favoriteMovie))
        self.navigationItem.setRightBarButton(button, animated: true)
        self.view.layoutIfNeeded()
    }

    // MARK: - Display

    func fetchMovie() {
        viewModel.fetchMovie { (movie) in
            DispatchQueue.main.async {
                self.displayGenres()
            }
        }
    }

    func displayGenres() {
        guard let genres = viewModel.movie.genres else { return }
        var genresText = "Gêneros: "
        for genre in genres {
            genresText += genre.name + ", "
        }
        self.genresLabel.text = String(genresText.dropLast(2))
    }

    // MARK: - Actions

    @objc func favoriteMovie() {
        viewModel.tougleIsfavorite { (movie) in
            DispatchQueue.main.async {
                if self.viewModel.isFavorite {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icon-star-full")
                } else {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icon-star")
                }
                self.view.layoutIfNeeded()
            }
        }
    }
}
