//
//  MovieTableViewCell.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol MovieTableViewCellDelegate {
    func favoriteRemoved() 
}

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var favourite: Favourite?
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureForMovie(_ movie: Movie) {
        if let meta = SessionManager.shared.imageConfig?.images {
            let base = meta.baseURL
            if let size = meta.posterSizes.first,
                let url = URL(string: "\(base)\(size)\(movie.posterPath ?? "")") {
                self.posterImageView.af_setImage(withURL: url)
            }
        }
        
        self.nameLabel.text = movie.originalTitle
        self.dateLabel.text = movie.releaseDate?.formatDate()
        self.movie = movie
        favourite = SessionManager.shared.getFavourite(movie)
        favoriteButton.isSelected = favourite != nil
    }
    @IBAction func favorited(_ sender: Any) {
        guard let movie = self.movie else {
            return
        }
        if self.favourite != nil {
            SessionManager.shared.deleteMovie(movie)
            self.favourite = nil
        }else {
            self.favourite = SessionManager.shared.saveMovie(movie)
        }
        
        favoriteButton.isSelected = favourite != nil
        
    }
}
