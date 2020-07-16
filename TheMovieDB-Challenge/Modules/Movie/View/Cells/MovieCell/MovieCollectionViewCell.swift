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
    @IBOutlet weak var imgLoadActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgLoadActivityIndicator.startAnimating()
        
    }

    func setupCell(movie: Movie) {
        
        //layer.cornerRadius = 6.0
        layer.masksToBounds = false
        layer.shadowRadius = 9
        layer.shadowOpacity = 2.3
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        if let urlString = movie.posterPath {
            
            self.movieImageView.loadUrlImageFromSDWeb(urlString: urlString, type: .banner, done: { [weak self] isLoadFinished in
                
                if isLoadFinished {
                    
                    self?.imgLoadActivityIndicator.stopAnimating()
                    
                }
                
            })
            
        }
        
        self.movieNameLabel.text = movie.title
        
    }
    
}
