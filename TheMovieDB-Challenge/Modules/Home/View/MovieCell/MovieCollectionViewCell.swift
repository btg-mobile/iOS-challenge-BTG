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

    private let BASE_IMG_URL = "https://image.tmdb.org/t/p/w1280/"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    let activity = UIActivityIndicatorView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    func setupView(){
     
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
            self.movieImageView.sd_setImage(with: URL(string: ("\(self.BASE_IMG_URL)\(urlString)")), placeholderImage: UIImage(named: "movie-placeholder"))
        }else{
            self.movieImageView.image = UIImage(named: "movie-placeholder")
        }
        
        self.movieNameLabel.text = movie.title
        
        if let str = movie.releaseDate {
            let index = str.firstIndex(of: "-")!
            let newStr = String(str[..<index])
            //self.movieYearLabel.text = newStr
        }
        
    }
    
}
