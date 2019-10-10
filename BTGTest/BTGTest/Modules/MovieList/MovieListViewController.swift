//
//  MovieListViewController.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

// MARK: - MovieListViewController
class MovieListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var contentView: UIView!


    // MARK: - View Model
    private var viewModel: MovieListViewInput!

    // MARK: - Private Paramethers
    private let refreshControll = UIRefreshControl()
    private var errorView: ErrorView?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieListViewModel(view: self)

        loadTableView()
        configureSearchBar()

        viewModel.fetchMovieList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = moviesTableView.indexPathForSelectedRow {
            moviesTableView.deselectRow(at: indexPath, animated: true)
        }

        moviesTableView.reloadData()
    }

    private func loadTableView() {
        moviesTableView
            .register(UINib(nibName: "MovieListTableViewCell", bundle: nil),
                      forCellReuseIdentifier: "movieListCell")

        moviesTableView.dataSource = self
        moviesTableView.delegate = self

        moviesTableView.keyboardDismissMode = .onDrag

        configureRefreshControl()
    }

    private func configureRefreshControl() {
        refreshControll.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        moviesTableView.addSubview(refreshControll)
    }

    private func configureSearchBar() {
        searchBar.delegate = self
    }

    private func openMovieDetail(_ movie: Movie) {
        let detailViewController = MovieDetailViewController(movie: movie)
        present(detailViewController, animated: true, completion: nil)
    }

    @objc private func refreshPulled() {
        viewModel.retrySearch()
    }
}

// MARK: - MovieListViewOutput
extension MovieListViewController: MovieListViewOutput {
    func reloadMovieTableView(resetScroll: Bool) {
        if let errorView = errorView {
            errorView.isHidden = true
        }

        moviesTableView.isHidden = false
        moviesTableView.reloadData()

        if resetScroll {
            moviesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }

        refreshControll.endRefreshing()
    }

    func startFullScreenLoading() {
        if let errorView = errorView {
            errorView.isHidden = true
        }

        moviesTableView.isHidden = true
        loadingActivityIndicator.startAnimating()
    }

    func stopFullScreenLoading() {
        loadingActivityIndicator.stopAnimating()
    }

    func showErrorMessage(_ message: String, tryAgain: Bool) {
        if errorView == nil {
            errorView = ErrorView.instance()
            errorView!.layout(into: contentView)
        }

        errorView!.setMessage(message)
        errorView!.enableTryAgainButton(tryAgain)

        errorView!.isHidden = false
        errorView!.delegate = self

        moviesTableView.isHidden = true
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }

        let movie = viewModel.movie(at: indexPath.row)
        cell.fill(movie: movie)
        cell.setFavourite(viewModel.isMovieFavorited(movie: movie))

        cell.didPressFavorite = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.toggleFavorite(at: indexPath.row)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        openMovieDetail(movie)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(at: indexPath.row)
    }
}

// MARK: - ErrorView Delegate
extension MovieListViewController: ErrorViewDelegate {
    func errorViewDidPressTryAgainButton(_ errorView: ErrorView) {
        viewModel.retrySearch()
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.resetSearch()
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()

        viewModel.fetchMovieList()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            searchBar.showsCancelButton = false
            return
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didChangeSearchText(searchText)
    }
}
