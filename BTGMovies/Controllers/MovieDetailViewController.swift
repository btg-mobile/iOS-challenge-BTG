//
//  MovieDetailViewController.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseYearLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    // MARK: - Init
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Constants
    private let viewModel: MovieViewModel
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayout()
        setFavImage()
    }

    // MARK: - Setups
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let rightItem: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favorites-tab-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(favoriteTapped))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc private func favoriteTapped(sender: UIBarButtonItem) {
        if viewModel.isFavorite {
            viewModel.removeMovie()
        } else {
            viewModel.saveMovie()
        }
        setFavImage()
    }
    
    private func setFavImage() {
        if viewModel.isFavorite {
            self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favorite-filled").withRenderingMode(.alwaysOriginal)
        } else {
            self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favorites-tab-icon").withRenderingMode(.alwaysOriginal)
        }
    }
    
    private func setupLayout() {
        coverImageView.setImage(path: viewModel.posterPath)
        backdropImageView.setImage(path: viewModel.backdropPath)
        titleLabel.text = viewModel.title
        releaseYearLabel.text = viewModel.releaseDate
        overviewLabel.text = viewModel.overview
    }
}
