//
//  HomeViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 08/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import Crashlytics

class HomeViewController: UIViewController {
    
    var controller: HomeController?
    var refreshControl: UIRefreshControl?
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var topRatedMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var popularMoviesActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nowPlayingMoviesActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var upcomingMoviesActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var topRatedMoviesActivityIndicator: UIActivityIndicatorView!
    
    var movieSelection: Constants.MovieSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshingControl()
        
        //Delegate and protocols
        controller = HomeController()
        controller?.delegate = self
        controller?.loadMovies(from: true, page: 1, category: .movie, movieSelection: .popular)
        
        ///Delegate and DataSource methods
        [popularMoviesCollectionView, nowPlayingMoviesCollectionView, upcomingMoviesCollectionView, topRatedMoviesCollectionView].forEach { $0.delegate = self }
        [popularMoviesCollectionView, nowPlayingMoviesCollectionView, upcomingMoviesCollectionView, topRatedMoviesCollectionView].forEach { $0.dataSource = self }
        
        ///Registereing Cells
        registerCells()
        
        ///Fire activity indicators
        startIndicators()
    }
    
    fileprivate func registerCells() {
        
        let nibName = "MovieCollectionViewCell"
        let identifier = "MovieCell"
        [popularMoviesCollectionView, nowPlayingMoviesCollectionView, upcomingMoviesCollectionView, topRatedMoviesCollectionView].forEach { $0.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier) }
        
    }
    
    ///Sets the StatusBar as white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
        
    }
    
    ///Fires the activity indicators
    func startIndicators() {
        
        popularMoviesActivityIndicator.startAnimating()
        nowPlayingMoviesActivityIndicator.startAnimating()
        upcomingMoviesActivityIndicator.startAnimating()
        topRatedMoviesActivityIndicator.startAnimating()
        
    }
    
    //MARK: - TapGestures
    @IBAction func tapToSeeMorePopularMovies(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        case 3:
            print("3")
        default:
            return
        }
        
        let storyboard = UIStoryboard.init(name: "Movies", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "MoviesList")
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)

    }
    
    func addRefreshingControl() {
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .lightGreen
        self.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.mainScrollView.addSubview(refreshControl ?? UIView())
        
    }
    
    @objc func refreshList() {
        
        refreshControl?.endRefreshing()
        controller?.loadMovies(from: true, page: 1, category: .movie, movieSelection: .popular)
        
        [popularMoviesCollectionView, nowPlayingMoviesCollectionView, upcomingMoviesCollectionView, topRatedMoviesCollectionView].forEach { $0?.reloadData() }
        
    }
    
}

    //MARK: - CollectionView Methods Extension

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 0:
            self.movieSelection = .popular
        case 1:
            self.movieSelection = .nowPlaying
        case 2:
            self.movieSelection = .upcoming
        case 3:
            self.movieSelection = .topRated
        default:
            break
        }
        
        return self.controller?.numberOfRows(movieSelection: self.movieSelection ?? Constants.MovieSelection.popular) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            self.movieSelection = .popular
        case 1:
            self.movieSelection = .nowPlaying
        case 2:
            self.movieSelection = .upcoming
        case 3:
            self.movieSelection = .topRated
        default:
            break
        }
        
        let cell : MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setupCell(movie: (self.controller?.loadMovieWithIndexPath(indexPath: indexPath, movieSelection: self.movieSelection ?? Constants.MovieSelection.popular, favorite: false))!)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return .init(width: view.frame.width / 3.4 , height: view.frame.height / 4)
        return .init(width: view.frame.width / 3.4 , height: 190.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10.0, left: 10, bottom: 20.0, right: 10)
        
    }
    
}

    //MARK: - Controller Protocol Methods

extension HomeViewController: HomeControllerDelegate {
    
    func successOnLoadingPopularMovies() {
        
        DispatchQueue.main.async {
            self.movieSelection = .popular
            self.popularMoviesCollectionView.reloadData()
            self.popularMoviesActivityIndicator.stopAnimating()
        }
        
    }
    
    func successOnLoadingNowPlayingMovies() {
        
        DispatchQueue.main.async {
            self.movieSelection = .nowPlaying
            self.nowPlayingMoviesCollectionView.reloadData()
            self.nowPlayingMoviesActivityIndicator.stopAnimating()
        }
        
    }
    
    func successOnLoadingUpcomingMovies() {
        
        DispatchQueue.main.async {
            self.movieSelection = .upcoming
            self.upcomingMoviesCollectionView.reloadData()
            self.upcomingMoviesActivityIndicator.stopAnimating()
        }
        
    }
    
    func successOnLoadingTopRatedMovies() {
    
        DispatchQueue.main.async {
            self.movieSelection = .topRated
            self.topRatedMoviesCollectionView.reloadData()
            self.topRatedMoviesActivityIndicator.stopAnimating()
        }
        
    }
    
    func errorOnLoading(error: Error?, type: Constants.MovieSelection) {
        
        print("Error \(error.debugDescription) on \(type.rawValue)")
        
    }
    
}
