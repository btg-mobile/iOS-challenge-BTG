//
//  ViewController.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit

protocol DisplayMoviesProtocol: class {
    func displayMovies(movies: [Movie])
    func displayErrorMovies(movieError: MovieError?)
    func displayMovieUsingPage(movies: [Movie])
}

class MovieViewController: UICollectionViewController, DisplayMoviesProtocol, FavoriteMovieProtocol {
    
    

    var collectionViewRefresh = UIRefreshControl()
    var interactor: MovieInteractorLogic!
    var router: MovieRouter!
    
    var data = [Movie]()
    var movieIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateView(visible: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setup() {
        let vc = self
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let router = MovieRouter()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        
        collectionViewRefresh.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        collectionViewRefresh.tintColor = UIColor.white
        collectionView.refreshControl = collectionViewRefresh
        
        interactor.getMovies()
    }
    
    private func animateView(visible: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = visible ? 1 : 0
        }
    }
    
    func displayMovies(movies: [Movie]) {
        data = movies
        collectionView.reloadData()
        collectionViewRefresh.endRefreshing()
    }
    
    func displayMovieUsingPage(movies: [Movie]) {
        data += movies
        collectionView.reloadData()
        collectionViewRefresh.endRefreshing()
    }
    
    func displayErrorMovies( movieError: MovieError?) {
        self.displayAlertDefault(withTitle: "Warning", message: "Offline, please try againg")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configCell(with: data[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieIndexPath = indexPath
        
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        router.goToDetail(showing: data[indexPath.row], thumb: cell.movieThumb.image!, from: self, to: detailVC)
       
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var page = 1
        if indexPath.row == self.data.count-1 {
            page += 1
            interactor.getMovies(withPages: page)
        }
    }
    
    @objc func handleRefresh() {
        print("handleRefresh()")
        interactor.getMovies()
    }
    func addFavoriteMovie(usingIndex indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        
        FavoriteCoreData.saveFavorite(movie: data[indexPath.row], thumb: cell.movieThumb.image!) { (error) in
            print("MovieCVC - addFavoriteMovie - Error: \(error?.localizedDescription ?? "none")")
        }
    }
    
    func deleteFavoriteMovie(usingIndex indexPath: IndexPath) {
        FavoriteCoreData.deleteFavorite(usingMovie: data[indexPath.row]) { (error) in
            print("MovieCVC - addFavoriteMovie - Error: \(error?.localizedDescription ?? "none")")
        }
    }
}

extension MovieViewController: ZoomTransitionDelegate {
    
    func zoomForBackgroundView(for transition: ZoomTransition) -> UIView? {
        return nil
    }
    
    func zoomCharacterImageView(for transition: ZoomTransition) -> UIImageView? {
        animateView(visible: false)
        let thumbIV: UIImageView!
        let tablV = self.collectionView.cellForItem(at: movieIndexPath) as! MovieCell
        thumbIV = tablV.movieThumb
        return thumbIV
    }
}
