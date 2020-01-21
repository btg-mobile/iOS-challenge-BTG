//
//  ListFavoritesViewController.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

class ListFavoritesViewController: UIViewController, MoviesViewInteractionLogic {

    private var viewModel = ListFavoritesViewModel()

    @IBOutlet private weak var moviesView: MoviesView!

    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      title = viewModel.viewTitle
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      title = viewModel.viewTitle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSarchController()
        fetchMovies()
    }

    // MARK: - Setup

    private func setup() {
        moviesView.viewController = self
    }

    private func setupSarchController() {
        let searchMoviesViewController = SearchMoviesViewController(sender: self)
        searchMoviesViewController.view.layoutIfNeeded()
        let searchController = UISearchController(searchResultsController: searchMoviesViewController)
        searchController.searchResultsUpdater = searchMoviesViewController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Nome do filme"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Display

    func fetchMovies(nextPage: Bool = false) {
        viewModel.fetchfavoriteMovies(nextPage: nextPage) { (movieViewModel) in
            DispatchQueue.main.async {
                self.moviesView.collectionView.refreshControl?.endRefreshing()
                self.moviesView.movies = movieViewModel.movies ?? []
                self.moviesView.collectionView.reloadData()
            }
        }
    }

    func displayMovieDetail(movie: Movie) {
        let controller = ShowMovieViewController(with: movie, isFavorite: true)
        guard let navigation = self.navigationController else { return }
        navigation.pushViewController(controller, animated: true)
    }

    // MARK: - Movies View Interaction Logic

    func didSelect(movie: Movie) {
        displayMovieDetail(movie: movie)
    }

    func loadMoreData() {
        fetchMovies(nextPage: true)
    }

    func refreshContent() {
        viewModel.movieViewModel = MovieViewModel()
        fetchMovies()
    }
}
