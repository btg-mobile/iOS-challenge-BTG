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
    
    var favorite:Movie! {
        didSet{
            setupView()
            setupBind()
        }
    }
    
    fileprivate func setupView() {
        spinerView.color = .black
        
        backdropImageView.contentMode = .scaleToFill
        backdropImageView.layer.cornerRadius = 5
        backdropImageView.clipsToBounds = true
        backdropImageView.anchor(width: UIScreen.main.bounds.width / 3.5)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        
        titleLabel.textColor = .black
        overviewLabel.textColor = .gray
        
        titleLabel.numberOfLines = 1
        overviewLabel.numberOfLines = 0
        
        let vStackView = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
        let hStackView = UIStackView(arrangedSubviews: [backdropImageView, vStackView])
        
        vStackView.axis = .vertical
        hStackView.spacing = 10
        
        addSubview(hStackView)
        hStackView.anchorFillSuperView(padding: 10)
        
        addSubview(spinerView)
        spinerView.anchor(
            centerX: (backdropImageView.centerXAnchor, 0),
            centerY: (backdropImageView.centerYAnchor, 0)
        )
    }
    
    fileprivate func setupBind(){
        titleLabel.text = favorite.title
        overviewLabel.text = favorite.overview
        
        if let url = APIResourceEnum.image(path: favorite.backdrop_path, size: .w500).url{
            backdropImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "img-default-2"), options: .continueInBackground){[weak self] (_, _, _, _) in
                self?.spinerView.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        spinerView.startAnimating()
        titleLabel.text = nil
        overviewLabel.text = nil
        backdropImageView.image = UIImage(named: "img-default-2")
    }
}
