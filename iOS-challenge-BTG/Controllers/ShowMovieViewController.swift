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

    init(with movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        viewModel.movie = movie
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
        self.genresLabel.text = ""
        if viewModel.movie.genres == nil {
            fetchMovie()
        } else {
            displayGenres()
        }

        navigationItem.largeTitleDisplayMode = .never
        posterImageView.loadImageUsing(path: viewModel.movie.largePosterPath)
        titleLabel.text = viewModel.movie.title
        releaseDateLabel.text = viewModel.movie.formatedReleaseDate
        voteAvarageLabel.text = "Nota \(viewModel.movie.voteAverage)"
        overviewLabel.text = viewModel.movie.overview
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

}
