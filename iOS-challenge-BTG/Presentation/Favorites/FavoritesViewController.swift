//
//  FavoritesViewController.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit
import RxSwift
import RxCocoa

// MARK: - Typealias

// MARK: - Protocols
protocol FavoritesDisplayLogic: class {
    func displayFetchedMovies()
    func displayError(message: String)
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    
    static func instantiate() -> FavoritesViewController {
        let vc = FavoritesViewController(nibName: String(describing: FavoritesViewController.self), bundle: nil)
        return vc
    }
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var interactor: (FavoritesBusinessLogic & FavoritesDataStore)?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMovies()
    }
    
    // MARK: - Public Methods
    func displayFetchedMovies() {
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func displayError(message: String) {
        Alert.shared.showMessage(message: message)
        self.tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Private Methods
    private func fetchMovies() {
        interactor?.fetchMovies()
    }
    
    private func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
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
        
        Observable<[MoviesResult]>.combineLatest(searchBar.rx.text.orEmpty.asObservable().map { $0.lowercased() }, self.interactor?.movies ?? Observable.just([])) {
            text, movies in
            
            return text.isEmpty ? movies : movies.filter { $0.title.lowercased().contains(text) }
            }.bind(to: self.tableView.rx.items(cellIdentifier: String(describing: MovieTableViewCell.self), cellType: MovieTableViewCell.self)) { row, element, cell in
                cell.setup(movie: element, isFavorite: element.isFavorite ?? false) { newState in
                    newState ? self.interactor?.favoriteMovie(movie: element) : self.interactor?.unfavoriteMovie(movie: element)
                }
            }.disposed(by: disposeBag)
        
        
        self.tableView.rx.itemSelected.map { $0 }.bind { indexPath in
            if let movie = self.interactor?.movie(indexPath: indexPath) {
                debugPrint(movie.id)
            }
            self.tableView.deselectRow(at: indexPath, animated: true)
            }.disposed(by: disposeBag)
    }
    
    @objc private func reloadFirstPage() {
        fetchMovies()
    }
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
