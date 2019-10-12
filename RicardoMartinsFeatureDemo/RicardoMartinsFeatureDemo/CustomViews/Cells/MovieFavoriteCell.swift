//
//  MovieFavoriteCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieFavoriteCell: UITableViewCell {
    fileprivate let titleLabel = UILabel()
    fileprivate let overviewLabel = UILabel()
    fileprivate let spinerView = UIActivityIndicatorView(style: .whiteLarge)
    fileprivate let backdropImageView = UIImageView()
    
    var favoriteButtonVM:FavoriteButtonVM! {
        didSet{
            setupView()
            configure()
        }
    }
    
    fileprivate func setupView() {
        // spinerView
        spinerView.color = .black
        
        // backdropImageView
        backdropImageView.contentMode = .scaleToFill
        backdropImageView.layer.cornerRadius = 5
        backdropImageView.clipsToBounds = true
        backdropImageView.anchor(width: UIScreen.main.bounds.width / 3.5)
        
        // titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        
        // overviewLabel
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        overviewLabel.textColor = .gray
        overviewLabel.numberOfLines = 0
        
        // stackViews
        let vStackView = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
        let hStackView = UIStackView(arrangedSubviews: [backdropImageView, vStackView])
        
        vStackView.axis = .vertical
        hStackView.spacing = 10
        
        addSubview(hStackView)
        hStackView.anchorFillSuperView(padding: 10)
        
        // spinerView
        addSubview(spinerView)
        spinerView.anchor(
            centerX: (backdropImageView.centerXAnchor, 0),
            centerY: (backdropImageView.centerYAnchor, 0)
        )
    }
    
    fileprivate func configure(){
        titleLabel.text = favoriteButtonVM.movie.value?.title
        overviewLabel.text = favoriteButtonVM.movie.value?.overview
        
        if let url = APIResourceEnum.image(path: favoriteButtonVM.movie.value?.backdrop_path, size: .w500).url{
            backdropImageView.sd_setImage(with: url, placeholderImage: ImageAssets.imgDefault2.image, options: .continueInBackground){[weak self] (_, _, _, _) in
                self?.spinerView.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        spinerView.startAnimating()
        titleLabel.text = nil
        overviewLabel.text = nil
        backdropImageView.image = ImageAssets.imgDefault2.image
    }
}
