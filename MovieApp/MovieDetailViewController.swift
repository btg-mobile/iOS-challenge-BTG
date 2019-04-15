//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Lucas Moraes on 12/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit
import CoreMotion

protocol DisplayMovieDetailDisplayProtocol {
    func displayFavorite(movie: FavoriteMovie)
    func display(movie: Movie, thumb: UIImage)
    func displayErrorOnMovie(error: Error)
}

final class MovieDetailViewController: UIViewController, DisplayMovieDetailDisplayProtocol {
    
    @IBOutlet weak var movieThumbIV: UIImageView!
    @IBOutlet weak var movieDescriptionTXV: UITextView!
    @IBOutlet weak var backgroundIThumbIV: UIImageView!
    @IBOutlet weak var movieRateLbl: UILabel!
    @IBOutlet weak var movieEffect: UIVisualEffectView!
    @IBOutlet weak var favBtn: UIButton!
    
    private var movieTitle: String?
    private var movieThumb: UIImage?
    private var movieDescrip: String?
    private var movieRate: Double?
    private var isFavorite: Bool!
    
    private var favoriteMovie: FavoriteMovie?
    private var singleMovie: Movie?
    
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 0
        }
    }
    
    func setup() {
        movieEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        movieEffect.alpha = 0.9
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = movieTitle
        
        movieThumbIV.clipsToBounds = true
        movieThumbIV.layer.cornerRadius = 5
        
        movieThumbIV.image = movieThumb
        backgroundIThumbIV.image = movieThumb
        movieDescriptionTXV.text = movieDescrip
        movieRateLbl.text = String(format: "%.1f", movieRate!)
        self.navigationItem.title = movieTitle
        applyMotion(backgroundIThumbIV, magnitude: 30)
        favBtn.setTitle(FavoriteCoreData.checkIfExists(with: movieTitle!) ? "Unfavorite" : "Favorite", for: UIControl.State.normal)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func displayMovieDetail(movie: Movie) {
        movieDescriptionTXV.text = movie.description
    }
    
    func displayFavorite(movie: FavoriteMovie) {
        movieThumb = movie.image as? UIImage
        movieDescrip = movie.descrip
        movieTitle = movie.title
        movieRate = movie.rate
        favoriteMovie = movie
        isFavorite = FavoriteCoreData.checkIfExists(with: movieTitle!)
    }
    
    func display(movie: Movie, thumb: UIImage) {
        movieThumb = thumb
        movieDescrip = movie.description
        movieTitle = movie.title
        movieRate = movie.rate
        singleMovie = movie
        isFavorite = FavoriteCoreData.checkIfExists(with: movieTitle!)
    }
    
    func displayErrorOnMovie(error: Error) {
        print("MovieDetailViewController - presentErrorOnMovie - Error: \(error.localizedDescription)")
    }
    
    @IBAction func favoriteMovie(_ sender: Any) {
        if isFavorite {
            favBtn.setTitle("Favorite", for: UIControl.State.normal)
            removeFavorite()
        } else {
            favBtn.setTitle("Unfavorite", for: UIControl.State.normal)
            addFavoriteMovie()
        }
    }
    
    func applyMotion(_ view: UIView, magnitude: Float) {
        
        let motionX = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffect.EffectType.tiltAlongHorizontalAxis)
        motionX.maximumRelativeValue = magnitude
        motionX.minimumRelativeValue = -magnitude
        
        let motionY = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffect.EffectType.tiltAlongVerticalAxis)
        motionY.maximumRelativeValue = magnitude
        motionY.minimumRelativeValue = -magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [motionX, motionY]
        
        view.addMotionEffect(group)
    }
    
    private func addFavoriteMovie() {
            FavoriteCoreData.saveFavorite(movie: singleMovie!, thumb: movieThumb!) { (error) in
                print("MovieDetailViewController - handleAddFavoriteMovie - Error: \(error?.localizedDescription ?? "none")")
            }
    }
    
    private func removeFavorite() {
        if isFavorite {
            FavoriteCoreData.deleteFavorite(favoriteMovie: favoriteMovie!) { (error) in
                print("MovieDetailViewController - handleAddFavoriteMovie - Error: \(error?.localizedDescription ?? "none")")
            }
        } else {
            FavoriteCoreData.deleteFavorite(usingMovie: singleMovie!) { (error) in
                print("MovieDetailViewController - handleAddFavoriteMovie - Error: \(error?.localizedDescription ?? "none")")
            }
        }
    }
}

extension MovieDetailViewController: ZoomTransitionDelegate {
    func zoomCharacterImageView(for transition: ZoomTransition) -> UIImageView? {
        return movieThumbIV
    }
    
    func zoomForBackgroundView(for transition: ZoomTransition) -> UIView? {
        return nil
    }
}
