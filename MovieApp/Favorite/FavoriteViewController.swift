//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by Lucas Moraes on 11/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit

class FavoriteViewController: UICollectionViewController, FavoriteMovieProtocol {
    
    var favoriteMovie = [FavoriteMovie]()
    var favoriteIndexPath: IndexPath!
    let router = MovieRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteMovie = FavoriteCoreData.getFavoriteMovies()
        collectionView.reloadData()
    }
    
   
    
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovie.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        cell.configCell(with: favoriteMovie[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favoriteIndexPath = indexPath
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        router.goToDetailFavorite(showing: favoriteMovie[indexPath.row], from: self, to: detailVC)
    }
    
    func addFavoriteMovie(usingIndex indexPath: IndexPath) { }
    
    func deleteFavoriteMovie(usingIndex indexPath: IndexPath) {
        FavoriteCoreData.deleteFavorite(favoriteMovie: favoriteMovie[indexPath.row]) { (error) in
            print("MovieCVC - deleteFavoriteMovie - Error: \(error?.localizedDescription ?? "none")")
            if error == nil {
                self.favoriteMovie = FavoriteCoreData.getFavoriteMovies()
                self.collectionView.reloadData()
                print(self.favoriteMovie)
            }
        }
    }
}


