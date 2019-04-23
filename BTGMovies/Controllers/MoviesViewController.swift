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
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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
        if case .popular = viewModel.screenType {
            tableView.refreshControl = refreshControl
        }
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
    }
    
    @objc private func refreshTableView() {
        viewState = .pullToRefresh
        loadData()
    }
    
    // MARK: - API
    
    private func loadData() {
        switch viewModel.screenType {
        case .popular:
            fetchMovies()
        case .favorites:
            getFavorites()
        }
    }
    
    private func fetchMovies() {
        self.viewState = .loading
        viewModel.getMovies { [weak self] success in
            guard let self = self else { return }
            if success {
                self.viewState = .default
                self.tableView.reloadData()
            } else {
                self.viewState = .error
            }
        }
    }
    
    private func getFavorites() {
        viewModel.initWithPersistence()
    }
    
    override var viewState: BaseViewController.ControllerState {
        didSet {
            switch viewState {
            case .loading:
                showActivityIndicator()
                tableView.restore()
            case .pullToRefresh:
                showActivityIndicator()
            case .error:
                removeActivityIndicator()
                refreshControl.endRefreshing()
                showAlert(message: "Erro ao buscar os filmes")
                tableView.setEmptyView(title: "Sem internet", message: "Não é possível encontrar filmes novos sem internet.")
            case .empty:
                switch viewModel.screenType {
                case .popular:
                    tableView.setEmptyView(title: "Ops!", message: "Nenhum filme encontrado com o título: \(searchTerms)")
                case .favorites:
                    if searchTerms.isEmpty {
                        tableView.setEmptyView(title: "Poxa", message: "Você ainda não favoritou nenhum filme. Vá para a aba filmes e clique no coraçãozinho!")
                    } else {
                        tableView.setEmptyView(title: "Ops!", message: "Você não tem nenhum filme favoritado com o título: \(searchTerms)")
                    }
                }
            case .default:
                removeActivityIndicator()
                refreshControl.endRefreshing()
                tableView.restore()
            }
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfMovies() == 0 && viewState != .loading {
            viewState = .empty
        } else {
            viewState = .default
        }
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

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movie(at: indexPath.row)
        MovieDetailViewController(viewModel: movie).open(flow: .push)
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
