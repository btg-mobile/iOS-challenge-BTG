//
//  HomeViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 08/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseCrashlytics
import GoogleSignIn

class HomeViewController: UIViewController {
    
    var controller: HomeController?
    var refreshControl: UIRefreshControl?
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var popularMoviesActivityIndicator: UIActivityIndicatorView!
    
    var movieSelection: Constants.MovieSelection?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshingControl()
        
        //Delegate and protocols
        controller = HomeController()
        controller?.delegate = self
        controller?.loadMovies(from: true, page: 1, category: .Movie, movieSelection: .Popular)
        
        ///Delegate and DataSource methods
        [popularMoviesCollectionView].forEach { $0.delegate = self }
        [popularMoviesCollectionView].forEach { $0.dataSource = self }
        
        ///Registereing Cells
        registerCells()
        
        ///Fire activity indicators
        startIndicators()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        guard let signIn = GIDSignIn.sharedInstance() else { return }
        
        if !signIn.hasPreviousSignIn() {
            
            perform(#selector(shouldShowOnboarding), with: self, afterDelay: 1)
        }
        
    }
    
    @objc func shouldShowOnboarding() {
        
        let identifier = "OnboardingViewControllerIdentifier"
    
        let homeStoryboard = UIStoryboard.init(name: "Onboarding", bundle: nil)
        
        let onbordingViewController = homeStoryboard.instantiateViewController(withIdentifier: identifier)
        
        self.present(onbordingViewController, animated: true)

    }
    
    //MARK: - Register Cells
    fileprivate func registerCells() {
        
        let nibName = "MovieCollectionViewCell"
        let identifier = "MovieCell"
        [popularMoviesCollectionView].forEach { $0.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier) }
        
    }
    
    //MARK: - Sets the StatusBar as white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
        
    }
    
    //MARK: - Fires the activity indicators
    func startIndicators() {
        
        popularMoviesActivityIndicator.startAnimating()
        
    }
    
    //MARK: - TapGestures
    @IBAction func tapToSeeMorePopularMovies(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            movieSelection = .Popular
            print("Popular")
        case 1:
            movieSelection = .NowPlaying
            print("Now Playing")
        case 2:
            movieSelection = .Upcoming
            print("Upcoming")
        case 3:
            movieSelection = .TopRated
            print("Top Rated")
        default:
            return
        }
        
        let storyboard = UIStoryboard.init(name: "Movies", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MoviesList") as! MovieViewController
        
        vc.movieSelection = movieSelection
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
   private func addRefreshingControl() {
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .lightGreen
        self.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.mainScrollView.addSubview(refreshControl ?? UIView())
        
    }
    
    @objc private func refreshList() {
        
        refreshControl?.endRefreshing()
        controller?.loadMovies(from: true, page: 1, category: .Movie, movieSelection: .Popular)
        
        [popularMoviesCollectionView].forEach { $0?.reloadData() }
        
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
            self.movieSelection = .Popular
        case 1:
            self.movieSelection = .NowPlaying
        case 2:
            self.movieSelection = .Upcoming
        case 3:
            self.movieSelection = .TopRated
        default:
            break
        }
        
        return self.controller?.numberOfRows(movieSelection: self.movieSelection ?? Constants.MovieSelection.Popular) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            self.movieSelection = .Popular
        case 1:
            self.movieSelection = .NowPlaying
        case 2:
            self.movieSelection = .Upcoming
        case 3:
            self.movieSelection = .TopRated
        default:
            break
        }
        
        let cell : MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setupCell(movie: (self.controller?.loadMovieWithIndexPath(indexPath: indexPath, movieSelection: self.movieSelection ?? Constants.MovieSelection.Popular, favorite: false))!)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return .init(width: view.frame.width / 3.4 , height: view.frame.height / 4)
        return .init(width: view.frame.width / 3.4 , height: 190.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10.0, left: 10, bottom: 20.0, right: 10)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Details", bundle: nil)
        
        let vc: DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewControllerID") as! DetailsViewController
        
        guard let movieSelected = self.movieSelection else { return }
        
        //Create a logic to get the collection the user is in. So, pass it as the movieSelection above
        
        vc.movie = controller?.loadMovieWithIndexPath(indexPath: indexPath, movieSelection: movieSelected)
        
        present(vc, animated: true, completion: nil)
        
    }
    
}

//MARK: - Controller Protocol Methods
extension HomeViewController: HomeControllerDelegate {
    
    func successOnLoadingPopularMovies() {
        
        DispatchQueue.main.async {
            self.movieSelection = .Popular
            self.popularMoviesCollectionView.reloadData()
            self.popularMoviesActivityIndicator.stopAnimating()
        }
        
    }
    
    func successOnLoadingNowPlayingMovies() {
        
        DispatchQueue.main.async {
            self.movieSelection = .NowPlaying
        }
        
    }
    
    func successOnLoadingUpcomingMovies() {
        
        DispatchQueue.main.async {
            self.movieSelection = .Upcoming
        }
        
    }
    
    func successOnLoadingTopRatedMovies() {
        
        DispatchQueue.main.async {
            self.movieSelection = .TopRated
        }
        
    }
    
    func errorOnLoading(error: Error?, type: Constants.MovieSelection) {
        
        print("Error \(error.debugDescription) on \(type.rawValue)")
        
    }
    
}
