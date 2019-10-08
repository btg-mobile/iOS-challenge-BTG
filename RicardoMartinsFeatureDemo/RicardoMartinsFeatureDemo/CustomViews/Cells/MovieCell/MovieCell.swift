//
//  MovieCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var spinerView: UIActivityIndicatorView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var yearBkgView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie:Movie! {
        didSet{
            spinerView.startAnimating()
            let year = movie.release_date?.components(separatedBy: "-")[0] ?? ""
            yearLabel.text = year
            yearLabel.textColor = .white
            yearBkgView.backgroundColor = UIColor.darkText.withAlphaComponent(0.5)
            yearBkgView.layer.cornerRadius = 5
            yearBkgView.clipsToBounds = true


            let name = movie.title?.uppercased() ?? "-"
            titleLabel.text = name
            
            posterImageView.contentMode = .scaleAspectFill
            posterImageView.layer.cornerRadius = 5
            
            if let url = APIResourceEnum.image(path: movie.poster_path, size: .original).url{
                posterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "img-default-1"), options: .continueInBackground) {[weak self] (_, _, _, _) in
                    self?.spinerView.stopAnimating()
                }
            }
   
            setShadow(color: .black, offset: .init(width: 2, height: 2), radius: 5, opacity: 0.6)
            layoutIfNeeded()
        }
    }
    
    override func prepareForReuse() {
        spinerView.startAnimating()
        posterImageView.image = UIImage(named: "img-default-1")
        spinerView.hidesWhenStopped = true
        titleLabel.text = nil
    }
}
