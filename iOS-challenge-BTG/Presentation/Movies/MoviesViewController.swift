//
//  MoviesViewController.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit
import SwiftOverlays
import RxSwift
import RxCocoa

// MARK: - Typealias

// MARK: - Protocols
protocol MoviesDisplayLogic: class {
    func displayFetchedMovies(viewModel: Movies.ViewModel)
    func displayError(viewModel: Movies.ViewModel)
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesViewController: UIViewController, MoviesDisplayLogic {
    
    static func instantiate() -> MoviesViewController {
        let vc = MoviesViewController(nibName: String(describing: MoviesViewController.self), bundle: nil)
        return vc
    }
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var interactor: (MoviesBusinessLogic & MoviesDataStore)?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?
    private var moviesResponse: MoviesResponse? = nil
    private var isLoaded: Bool = true
    
    // MARK: - Lets
    private let disposeBag = DisposeBag()

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchMovies(page: 1)
    }
    
    // MARK: - Public Methods
    func fetchMovies(page: Int) {
        self.isLoaded = false
        SwiftOverlays.showBlockingWaitOverlay()
        let request = Movies.Request(page: page)
        interactor?.fetchMovies(request: request)
    }
    
    func displayFetchedMovies(viewModel: Movies.ViewModel) {
        self.isLoaded = true
        self.moviesResponse = viewModel.movies
        SwiftOverlays.removeAllBlockingOverlays()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func displayError(viewModel: Movies.ViewModel) {
        self.isLoaded = true
        SwiftOverlays.removeAllBlockingOverlays()
        Alert.shared.showMessage(message: viewModel.errorMessage ?? K.Messages.Unknown)
        self.tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Private Methods
    private func setup() {
        let viewController = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadFirstPage), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        self.tableView.registerNib(MovieTableViewCell.self)
        self.interactor?.movies.bind(to: self.tableView.rx.items(cellIdentifier: String(describing: MovieTableViewCell.self), cellType: MovieTableViewCell.self)) { row, element, cell in
            cell.setup(movie: element) {
                self.interactor?.favoriteMovie(movie: element)
            }
            }.disposed(by: disposeBag)
        
        self.tableView.rx.didScroll.map { $0 }.bind {
            let offset: CGFloat = 200
            let bottomEdge = self.tableView.contentOffset.y + self.tableView.frame.size.height
            if (bottomEdge + offset >= self.tableView.contentSize.height) {
                if let actual = self.moviesResponse?.page,
                    let totalPages = self.moviesResponse?.totalPages,
                    actual < totalPages && self.isLoaded {
                    self.fetchMovies(page: actual + 1)
                }
            }
            }.disposed(by: disposeBag)
        
        //        self.coinsTableView.rx.itemSelected.map { $0 }.bind { indexPath in
        //            guard let coin = self.viewModel?.retrieveCoin(indexPath) else { return }
        //            let position = self.coinsTableView.convert(self.coinsTableView.rectForRow(at: indexPath), to: self.view)
        //            self.coordinator?.showDetails(coin: coin, position: position)
        //            self.coinsTableView.deselectRow(at: indexPath, animated: true)
        //            }.disposed(by: disposeBag)
    }
    
    @objc private func reloadFirstPage() {
        fetchMovies(page: 1)
    }
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
