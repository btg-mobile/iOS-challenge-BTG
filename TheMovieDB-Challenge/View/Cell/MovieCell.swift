//
//  MovieCell.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    private let BASE_IMG_URL = "https://image.tmdb.org/t/p/w1280/"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(movie: Movie) {
        
        if let urlString = movie.backdropPath {
            self.movieImageView.sd_setImage(with: URL(string: ("\(self.BASE_IMG_URL)\(urlString)")), placeholderImage: UIImage(named: "placeholder"))
        }else{
            self.movieImageView.image = UIImage(named: "placeholder")
        }
        
        self.movieNameLabel.text = movie.title
        
        if let str = movie.releaseDate {
            let index = str.firstIndex(of: "-")!
            let newStr = String(str[..<index])
            self.movieYearLabel.text = newStr
        }
        
        //ColorsFromImage(movie.backdropPath, isFlatScheme)
        
    }
    
}
