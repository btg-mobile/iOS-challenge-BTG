//
//  FavoritesViewController.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet private weak var favoritesTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var contentView: UIView!

    private var viewModel: FavoritesViewInput!

    private var errorView: ErrorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = FavoritesViewModel(view: self)

        loadTableView()
        configureSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = favoritesTableView.indexPathForSelectedRow {
            favoritesTableView.deselectRow(at: indexPath, animated: true)
        }

        if let text = searchBar.text, !text.isEmpty {
            viewModel.didChangeSearchText(text)
        } else {
            viewModel.fetchFavoriteList()
        }
    }

    private func loadTableView() {
        favoritesTableView
            .register(UINib(nibName: "MovieListTableViewCell", bundle: nil),
                      forCellReuseIdentifier: "movieListCell")

        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self

        favoritesTableView.keyboardDismissMode = .onDrag
    }

    private func configureSearchBar() {
        searchBar.delegate = self
    }

    private func openMovieDetail(_ movie: Movie) {
        let detailViewController = MovieDetailViewController(movie: movie)
        present(detailViewController, animated: true, completion: nil)
    }
}

extension FavoritesViewController: FavoritesViewOutput {
    func reloadFavoriteTableView(resetScroll: Bool) {
        if let errorView = errorView {
            errorView.isHidden = true
        }

        favoritesTableView.isHidden = false
        favoritesTableView.reloadData()

        if resetScroll {
            favoritesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }

    func showErrorMessage(_ message: String) {
        if errorView == nil {
            errorView = ErrorView.instance()
            errorView!.layout(into: contentView)
        }

        errorView!.setMessage(message)
        errorView!.enableTryAgainButton(false)

        errorView!.isHidden = false

        favoritesTableView.isHidden = true
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }

        let movie = viewModel.movie(at: indexPath.row)
        cell.fill(movie: movie, showFavouriteButton: false)

        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        openMovieDetail(movie)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE_ROW".localized) { (action, indexPath) in
            self.viewModel.deleteFavorite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        return [deleteAction]
    }
}

extension FavoritesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.resetSearch()

        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()

        viewModel.fetchFavoriteList()
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
