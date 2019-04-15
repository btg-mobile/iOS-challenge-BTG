//
//  MovieCTV.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit
import Kingfisher

protocol FavoriteMovieProtocol {
    func addFavoriteMovie(usingIndex indexPath: IndexPath)
    func deleteFavoriteMovie(usingIndex indexPath: IndexPath)
}

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieThumb: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    let touchFav = UITapGestureRecognizer()
    var delegate: FavoriteMovieProtocol!
    var movieIndexPath: IndexPath!
    var movie: Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieThumb.clipsToBounds = true
        movieThumb.layer.cornerRadius = 5
        // remenber to apply shadow
        
    }
    
    func configCell(with data: Movie, indexPath: IndexPath) {
        let imageURL = URL(string: MovieURL.baseImageURL + data.imageUrl)
        
        movieTitle.text = data.title
        movieDate.text = data.date
        movieThumb.kf.setImage(with: imageURL)
        movie = data
        movieIndexPath = indexPath
    }
    
    func animateImageThumb() {
        if movieThumb.image == nil {
            UIView.animate(withDuration: 0.7) {
                self.alpha = 1
            }
        }
    }
    
    @IBAction func handleTouchFav(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(named: "heartNotFill") {
            sender.imageView?.image = UIImage(named: "heartFill")
            self.delegate.addFavoriteMovie(usingIndex: movieIndexPath)
        } else {
            sender.imageView?.image = UIImage(named: "heartNotFill")
            self.delegate.deleteFavoriteMovie(usingIndex: movieIndexPath)
        }
    }
}


