//
//  MovieCollectionViewCell.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 08/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var movieImageView: CustomImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var imgLoadActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
        
    }
    
    func setupView() {
     
        mainView.layer.cornerRadius = 8.0
        movieImageView.layer.cornerRadius = 8.0
        
        formatViewsWithDropShadow(self)
    }

    func formatViewsWithDropShadow(_ view: UIView) {
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        view.layer.shadowRadius = 5.0
        
    }
    
    func setupCell(movie: Movie) {
        
        if let urlString = movie.posterPath {
            
            self.movieImageView.loadUrlImageFromSDWeb(urlString: urlString, type: .banner)
            
        }
        
        self.movieNameLabel.text = movie.title
        
    }
    
}
