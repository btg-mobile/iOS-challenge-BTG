//
//  DetailsViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    private let BASE_IMG_URL = "https://image.tmdb.org/t/p/original/"
    @IBOutlet weak var moviePhoto: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadMovie()
        // Do any additional setup after loading the view.
    }
    
    
    func loadMovie(){
        
        if let urlString = self.movie?.posterPath {
            self.moviePhoto.sd_setImage(with: URL(string: ("\(self.BASE_IMG_URL)\(urlString)")), placeholderImage: UIImage(named: "placeholder"))
        }else{
            self.moviePhoto.image = UIImage(named: "placeholder")
        }
        
        self.movieName.text = movie?.title
        self.moviePlot.text = movie?.overview
        //self.movieRating.text = String(movie?.voteAverage)
        
    }
    
    
}
