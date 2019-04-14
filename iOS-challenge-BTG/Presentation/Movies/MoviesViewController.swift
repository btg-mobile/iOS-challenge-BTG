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
    func displayFetchedMovies(response: MoviesResponse)
    func displayError(message: String)
    func displayDetails()
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
    var interactor: MoviesBusinessLogic?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?
    private var moviesResponse: MoviesResponse? = nil
    private var canLoadMore: Bool = true
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchMovies(page: 1)
    }
    
    // MARK: - Public Methods
    func displayFetchedMovies(response: MoviesResponse) {
        if let text = searchBar.text, text.isEmpty {
            self.canLoadMore = true
        }
        self.moviesResponse = response
        SwiftOverlays.removeAllBlockingOverlays()
        self.tableView.refreshControl?.endRefreshing()
        self.dismissErrorView()
        self.tableView.isUserInteractionEnabled = true
    }
    
    func displayError(message: String) {
        self.canLoadMore = true
        SwiftOverlays.removeAllBlockingOverlays()
        self.showErrorView(title: "Filmes", message: message, disposeBag: self.disposeBag) {
            self.reloadFirstPage()
        }
        self.tableView.isUserInteractionEnabled = false
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func displayDetails() {
        self.router?.routeDetails()
    }
    
    // MARK: - Private Methods
    private func fetchMovies(page: Int) {
        self.canLoadMore = false
        SwiftOverlays.showBlockingWaitOverlay()
        interactor?.fetchMovies(page: page)
    }
    
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
        
        searchBar.rx.text.orEmpty.asObservable().map { $0 }.bind(onNext: { query in
            self.canLoadMore = query.isEmpty ? true : false
        }).disposed(by: disposeBag)
        
        self.tableView.registerNib(MovieTableViewCell.self)
        
        let movies = Observable<[Movie]>.combineLatest(searchBar.rx.text.orEmpty.asObservable().map { $0.lowercased() }, self.interactor?.movies ?? Observable.just([])) {
            text, movies in
            return text.isEmpty ? movies : movies.filter { $0.title.lowercased().contains(text) }
        }
        
        movies.bind { movies in
            if movies.isEmpty {
                self.showErrorView(title: "Filmes", message: "Nenhum resultado encontrado", hasButton: false,
                                   topConstraint: self.searchBar.snp.bottom, disposeBag: self.disposeBag)
                self.tableView.isUserInteractionEnabled = false
            } else {
                self.dismissErrorView()
                self.tableView.isUserInteractionEnabled = true
            }
        }.disposed(by: disposeBag)
        
        movies.bind(to: self.tableView.rx.items(cellIdentifier: String(describing: MovieTableViewCell.self), cellType: MovieTableViewCell.self)) { row, element, cell in
                cell.setup(movie: element, isFavorite: element.isFavorite ?? false) { newState in
                    newState ? self.interactor?.favoriteMovie(movie: element) : self.interactor?.unfavoriteMovie(movie: element)
                }
            }.disposed(by: disposeBag)
        
        self.tableView.rx.didScroll.map { $0 }.bind {
            let offset: CGFloat = 20
            let bottomEdge = self.tableView.contentOffset.y + self.tableView.frame.size.height
            if (bottomEdge + offset >= self.tableView.contentSize.height) {
                if let actual = self.moviesResponse?.page,
                    let totalPages = self.moviesResponse?.totalPages,
                    actual < totalPages && self.canLoadMore {
                    self.fetchMovies(page: actual + 1)
                }
            }
            }.disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected.map { $0 }.bind { indexPath in
            if let movie = self.interactor?.movie(indexPath: indexPath) {
                self.interactor?.setId(id: movie.id)
            }
            self.tableView.deselectRow(at: indexPath, animated: true)
            }.disposed(by: disposeBag)
    }
    
    @objc private func reloadFirstPage() {
        fetchMovies(page: 1)
    }
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
