//
//  FavoriteCell.swift
//  MovieApp
//
//  Created by Lucas Moraes on 14/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    @IBOutlet weak var movieThumb: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    var movieIndexPath: IndexPath!
    var delegate: FavoriteMovieProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieThumb.clipsToBounds = true
        movieThumb.layer.cornerRadius = 5
        
    }
    
    func configCell(with data: FavoriteMovie, indexPath: IndexPath) {
        
        movieTitle.text = data.title
        movieDate.text = data.date
        movieThumb.image = data.image as? UIImage
        movieIndexPath = indexPath
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
