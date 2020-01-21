//
//  SearchMoviesViewController.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 21/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

class SearchMoviesViewController: UIViewController, MoviesViewInteractionLogic, UISearchResultsUpdating {

    private var viewModel = SearchMoviesViewModel()

    @IBOutlet private weak var moviesView: MoviesView!

    // MARK: - Object lifecycle

    init(sender: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel.sender = sender
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup

    func setup() {
        moviesView.viewController = self
    }

    // MARK: - Display

    func fetchMovies(search: String, nextPage: Bool = false) {
        viewModel.fetchMovies(search: search, nextPage: nextPage) { (movieViewModel) in
            DispatchQueue.main.async {
                self.moviesView.movies = movieViewModel.movies ?? []
                self.moviesView.collectionView.reloadData()
            }
        }
    }

    func displayMovieDetail(movie: Movie) {
        let controller = ShowMovieViewController(with: movie)
        guard let navigation = viewModel.sender.navigationController else { return }
        navigation.pushViewController(controller, animated: true)
    }

    // MARK: - Search

    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(search(text:)), with: (searchController.searchBar.text ?? ""), afterDelay: 1)
    }

    @objc func search(text: String) {
        if !text.isEmpty {
            fetchMovies(search: text)
        }
    }

    // MARK: - Movies View Interaction Logic

    func didSelect(movie: Movie) {
        DispatchQueue.main.async {
            self.displayMovieDetail(movie: movie)
        }
    }

    func loadMoreData() {
        DispatchQueue.main.async {
            guard let search = self.viewModel.movieViewModel.search else { return }
            self.fetchMovies(search: search, nextPage: true)
        }
    }

    func refreshContent() {
        moviesView.collectionView.refreshControl?.endRefreshing()
    }
}



