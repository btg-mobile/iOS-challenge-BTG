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
import FirebaseCrashlytics
import AVKit
import AVFoundation

//import Hero

class DetailsViewController: UIViewController {
    
    let realm = try! Realm()
    var genreIDS : Results<Item>?
    
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    //var controller : MovieController?
    
    @IBOutlet weak var moviePhoto: CustomImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var favoriteView: UIView!
    
    var movie : Movie? {
        
        didSet {
            
            loadGenres()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.controller = MovieController()
        
        self.setupCell()
        
    }
    
    //MARK: - Sets the StatusBar as white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
        
    }
    
    @IBAction func tappedGoBack(_ sender: UIButton) {
            
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        
        //let videoPath = URL(string: "https://www.youtube.com/watch?v=Bw0-cV_J9q4&feature=youtu.be")
        
        let selectedVideo = Bundle.main.path(forResource: "presentingVideo", ofType: "mp4")
        
        let videoPath = URL(fileURLWithPath: selectedVideo ?? "")
        
        player = AVPlayer(url: videoPath)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            self.player.play()
        })
        
    }
    
    private func loadGenres() {
        
        genreIDS = realm.objects(Item.self)
        
    }
    
    func setGenres(idArray: [Int]?) -> String {
        
        if let id = idArray {
            
            if id.count != 0 {
                
                var genresByName = ""
                
                //percorre os IDS
                for genreCodes in id {
                    //Percorre o Movie em busca do ID
                    if let categoryForDeletion = self.genreIDS {
                        
                        for search in categoryForDeletion {
                            
                            if search.id == genreCodes {
                                genresByName.append(search.name + ", ")
                            }
                            
                        }
                    }
                    
                }
                
                //let size = (genresByName.count - 2)
                //let str = genresByName[0..<size] + "."
                
                return genresByName
                
            }
            
        }
        
        return "Não foi possivel identificar generos."
    }
    
//    func setFavButtonStatus(){
//        if let resp = self.controller?.isFavorite(id: movie?.id ?? 0) {
//
//            if resp == true {
//                self.btnFavorite.setImage(#imageLiteral(resourceName: "filledHeart_icon") , for: .normal)
//            }
//            else{
//                self.btnFavorite.setImage(#imageLiteral(resourceName: "emptyHeart_icon") , for: .normal)
//            }
//        }
//    }
    
    func setupCell() {
        
        favoriteView.layer.cornerRadius = favoriteView.frame.width / 2
        
        //self.setFavButtonStatus()
        
        if let urlString = self.movie?.backdropPath {
            self.moviePhoto.loadUrlImageFromSDWeb(urlString: urlString, type: .cover)
        }else {
            self.moviePhoto.image = UIImage(named: "placeholder")
        }
        
        self.movieName.text = movie?.title
        self.moviePlot.text = movie?.overview
        self.movieRating.text = movie?.voteAverage?.toStringWithStar()
        self.movieGenre.text = self.setGenres(idArray: movie?.genreIDS ?? [])
        
    }
    
//    @IBAction func btnFavoriteTapped(_ sender: UIButton) {
//
//        //verifica status fav / percorre o array e verifica se existe
//
//        if (self.controller?.isFavorite(id: self.movie?.id ?? 0))! {
//
//            let alerta = UIAlertController(title: "Aviso", message: "Filme removido dos favoritos.", preferredStyle: .alert)
//            let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
//
//            alerta.addAction(btnOk)
//
//            self.present(alerta, animated: true)
//
//            if let removeId = self.movie?.id {
//
//                self.controller?.removeFavoriteMovie(id: removeId)
//
//            }
//
//            self.setFavButtonStatus()
//
//        }
//        else {
//
//            let alerta = UIAlertController(title: "Salvo", message: "Filme \(self.movie?.title ?? "") salvo nos favoritos.", preferredStyle: .alert)
//            let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
//
//            alerta.addAction(btnOk)
//
//            self.present(alerta, animated: true)
//
//            if let selectedMovie = self.movie {
//                self.controller?.saveFavoriteMovie(movie: selectedMovie)
//            }
//
//            self.setFavButtonStatus()
//
//        }
//
//    }
    
}
