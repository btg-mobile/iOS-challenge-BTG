//
//  MovieDetailsViewController.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit
import SwiftOverlays
import RxSwift
import RxCocoa
import Kingfisher

// MARK: - Typealias

// MARK: - Protocols
protocol MovieDetailsDisplayLogic: class {
    func displayFetchedMovie(movie: Movie)
    func displayError(message: String)
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MovieDetailsViewController: UIViewController, MovieDetailsDisplayLogic {
    
    static func instantiate() -> MovieDetailsViewController {
        let vc = MovieDetailsViewController(nibName: String(describing: MovieDetailsViewController.self), bundle: nil)
        return vc
    }
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var topDetailsConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - Vars
    var interactor: MovieDetailsBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    private var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(UIImage(named: self.isFavorite ? "star_filled" : "star"), for: .normal)
        }
    }
    
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
        fetchMovie()
    }
    
    // MARK: - Public Methods
    func displayFetchedMovie(movie: Movie) {
        SwiftOverlays.removeAllBlockingOverlays()
        self.posterImageView.kf.indicatorType = IndicatorType.activity
        self.posterImageView.kf.setImage(with: URL(string: K.ApiServer.Poster(path: movie.posterPath))!)
        self.titleLabel.text = movie.title
        self.isFavorite = movie.isFavorite ?? false
        self.voteAverageLabel.text = "\(movie.voteAverage)"
        if let genres = movie.genres {
            var genresText = ""
            for index in 0..<genres.count {
                genresText.append(index == 0 ? genres[index].name : ", \(genres[index].name)")
            }
            self.genresLabel.text = genresText
        }
        self.overviewLabel.text = movie.overview
        
        self.favoriteButton.rx.tap.map { $0 }.bind {
            self.isFavorite = !self.isFavorite
            self.isFavorite ? self.interactor?.favoriteMovie(movie: movie) : self.interactor?.unfavoriteMovie(movie: movie)
            }.disposed(by: self.disposeBag)
    }
    
    func displayError(message: String) {
        SwiftOverlays.removeAllBlockingOverlays()
        Alert.shared.showMessage(message: message)
    }
    
    // MARK: - Private Methods
    private func fetchMovie() {
        SwiftOverlays.showBlockingWaitOverlay()
        self.interactor?.fetchMovie()
    }
    
    private func setup() {
        let viewController = self
        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter()
        let router = MovieDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureView() {
        let heightScreen = UIScreen.main.bounds.height
        let heightNavigationPlusStatusBar = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0)
        let heightTabBar = (self.navigationController?.tabBarController?.tabBar.frame.height ?? 0)
        self.topDetailsConstraint.constant = (heightScreen - (heightNavigationPlusStatusBar - heightTabBar)) * 0.75
        
        self.titleLabel.text = ""
        self.voteAverageLabel.text = ""
        self.genresLabel.text = ""
        self.overviewLabel.text = ""
    }
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
