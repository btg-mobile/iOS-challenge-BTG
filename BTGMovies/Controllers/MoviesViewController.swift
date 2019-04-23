//
//  MoviesViewController.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class MoviesViewController: BaseViewController {
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Constants
    private let viewModel: MoviesViewModel
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Variables
    private var searchTerms = ""
    private var searchWasCancelled = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        switch viewModel.screenType {
        case .popular:
            fetchMovies()
        case .favorites:
            getFavorites()
        }
        
        setupTableView()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationLargeTitle(title: viewModel.screenType == .popular ? "Filmes" : "Favoritos")
        if case .favorites = viewModel.screenType {
            getFavorites()
        }
        tableView.reloadData()
    }
    
    // MARK: - Setups
    private func setupTableView() {
        tableView.register(MovieMainTableViewCell.self)
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - API
    private func fetchMovies() {
        self.showActivityIndicator()
        viewModel.getMovies { [weak self] success in
            guard let self = self else { return }
            self.removeActivityIndicator()
            if success {
                self.tableView.reloadData()
            } else {
                print("error")
            }
        }
    }
    
    private func getFavorites() {
        viewModel.initWithPersistence()
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieMainTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(movie: viewModel.movie(at: indexPath.row))
        cell.favoriteTapped = { [weak self] favorited in
            guard let self = self else { return }
            if favorited {
                self.viewModel.saveMovie(at: indexPath.row)
            } else {
                self.viewModel.removeMovie(at: indexPath.row)
                if case .favorites = self.viewModel.screenType {
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
                self.tableView.reloadData()
            }
        }
        return cell
    }
}

// MARK: - Search Bar
extension MoviesViewController {
    
    private func setupSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.placeholder = "Buscar por nome (ex: vingadores)"
        self.searchController.searchBar.delegate = self
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }
    
    private func searchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return self.searchController.isActive && !self.searchBarIsEmpty()
    }
    
}

// MARK: - UISearchResultsUpdating Delegate
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 0.5)
    }

    @objc private func reload() {
        viewModel.filterMovies(text: searchTerms)
        tableView.reloadData()
//
//        if !searchBarIsEmpty() {
//            fetchMovie(with: searchTerms)
//        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchWasCancelled = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchWasCancelled = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerms = searchText
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !searchWasCancelled {
            searchBar.text = self.searchTerms
        } else {
            searchTerms = ""
            reload()
        }
    }
}
