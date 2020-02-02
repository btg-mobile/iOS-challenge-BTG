//
//  DetailsViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class DetailsViewController: UIViewController {
    
    var controller : MovieController?
    
    private let BASE_IMG_URL = "https://image.tmdb.org/t/p/original/"
    @IBOutlet weak var moviePhoto: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var movie : Movie?
    
    var genreIDS : [GenreElement]? {
        
        didSet{
            print("Recebi um array de Genre")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller = MovieController()
        
        self.setupCell()
        
    }
    
    func setGenres(id: [Int]) -> String {
        
        var genresByName = ""
        
        //percorre os IDS
        for genreCodes in id {
            //Percorre o Movie em busca do ID
            for search in self.genreIDS ?? [] {

                if search.id == genreCodes {
                    genresByName.append(search.name + ", ")
                }
                
            }
            
        }
        
        let size = (genresByName.count - 2)
        let str = genresByName[0..<size] + "."

        
        return str
        
    }
    
    func setFavButtonStatus(){
        if let resp = self.controller?.isFavorite(id: movie?.id ?? 0) {
            
            if resp == true {
                self.btnFavorite.setImage(#imageLiteral(resourceName: "filledHeart_icon") , for: .normal)
            }
            else{
                self.btnFavorite.setImage(#imageLiteral(resourceName: "emptyHeart_icon") , for: .normal)
            }
        }
    }
    
    func setupCell(){
        
        self.setFavButtonStatus()
        
        if let urlString = self.movie?.posterPath {
            self.moviePhoto.sd_setImage(with: URL(string: ("\(self.BASE_IMG_URL)\(urlString)")), placeholderImage: UIImage(named: "placeholder"))
        }else{
            self.moviePhoto.image = UIImage(named: "placeholder")
        }
        
        self.movieName.text = movie?.title
        self.moviePlot.text = movie?.overview
        self.movieRating.text = movie?.voteAverage?.toStringWithStar()
        self.movieGenre.text = "Genero: \(self.setGenres(id: movie?.genreIDS ?? []))"
        
    }
    
    @IBAction func btnFavoriteTapped(_ sender: UIButton) {
        
        //verifica status fav / percorre o array e verifica se existe
        
        if (self.controller?.isFavorite(id: self.movie?.id ?? 0))! {
            
            let alerta = UIAlertController(title: "Aviso", message: "Filme removido dos favoritos.", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alerta.addAction(btnOk)
            
            self.present(alerta, animated: true)
            
            if let removeId = self.movie?.id {
                
                self.controller?.removeFavoriteMovie(id: removeId)
                
            }
            
            self.setFavButtonStatus()
            
        }
        else {
            
            let alerta = UIAlertController(title: "Salvo", message: "Filme \(self.movie?.title ?? "") salvo nos favoritos.", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alerta.addAction(btnOk)
            
            self.present(alerta, animated: true)
            
            if let selectedMovie = self.movie {
                self.controller?.saveFavoriteMovie(movie: selectedMovie)
            }
            
            self.setFavButtonStatus()
            
        }
        
    }
    
}
