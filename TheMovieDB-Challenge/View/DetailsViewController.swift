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
    
    var controller : MovieController?
    
    private let BASE_IMG_URL = "https://image.tmdb.org/t/p/original/"
    @IBOutlet weak var moviePhoto: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var movie : Movie? {
        
        didSet{
            print("didset")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller = MovieController()
        
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
        self.movieRating.text = movie?.voteAverage?.toStringWithStar()
        self.movieGenre.text = "Generos "//String(movie?.genreIDS?.count)
        
    }
    
    func getGenreDescription(){
        
        //Fazer chamada para buscar os generos a partir do array de genre
        
    }
    
    
    @IBAction func btnFavoriteTapped(_ sender: UIButton) {
        
        //quanto o usuario favoritar, fazer o append em array de favoritos
        
        let alerta = UIAlertController(title: "Salvo", message: "Filme \(self.movie?.title ?? "") salvo nos favoritos.", preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
         
         alerta.addAction(btnOk)
         
         self.present(alerta, animated: true)
        
        var favorite : Bool
        
        if let selectedMovie = self.movie {
            self.controller?.saveFavoriteMovie(movie: selectedMovie)
        }
        
        
        //        if favorite {
        //
        //        }
        
        //    let result = favorite ? print("true") : print("false")
        
        
    }
    
    
    
}

extension Double {
    func toStringWithStar() -> String {
        return "⭐️ " + String(format: "%.1f",self)
    }
}
