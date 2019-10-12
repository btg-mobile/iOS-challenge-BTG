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
    let spinerView = UIActivityIndicatorView(style: .whiteLarge)
    let posterImageView = UIImageView()
    let yearLabel = UILabel()
    let titleLabel = UILabel()
    var favoriteButton = FavoriteButton()
    
    var viewModel:MovieDetailVM! {
        didSet{
            configureCell()
            setupView()
        }
    }
    
    fileprivate func configureCell(){
        favoriteButton = FavoriteButton(movie: viewModel.movie.value)
        
        spinerView.color = .black
        spinerView.startAnimating()
        let year = viewModel.movie.value?.release_date?.components(separatedBy: "-")[0] ?? ""
        yearLabel.text = year
        yearLabel.font = UIFont.boldSystemFont(ofSize: 20)
        yearLabel.textAlignment = .center
        yearLabel.textColor = .white
        yearLabel.backgroundColor = UIColor.darkText.withAlphaComponent(0.5)
        yearLabel.layer.cornerRadius = 5
        yearLabel.clipsToBounds = true
        
        titleLabel.text = viewModel.movie.value?.title?.uppercased() ?? "-"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 5
        posterImageView.clipsToBounds = true
        
        if let url = APIResourceEnum.image(path: viewModel.movie.value?.poster_path, size: .original).url{
            posterImageView.sd_setImage(with: url, placeholderImage: ImageAssets.imgDefault1.image, options: .continueInBackground) {[weak self] (_, _, _, _) in
                self?.spinerView.stopAnimating()
            }
        }
        
        setShadow(color: .black, offset: .init(width: 2, height: 2), radius: 5, opacity: 0.6)
    }
    
    fileprivate func setupView(){
        addSubview(titleLabel)
        titleLabel.anchor(
            left: (leftAnchor, 10),
            right: (rightAnchor, 10),
            bottom: (bottomAnchor, 10),
            height: 50
        )
        
        addSubview(posterImageView)
        posterImageView.anchor(
            top: (topAnchor, 10),
            left: (leftAnchor, 10),
            right: (rightAnchor, 10),
            bottom: (titleLabel.topAnchor, 5)
        )
        
        addSubview(yearLabel)
        yearLabel.anchor(
            top: (topAnchor, 10),
            left: (leftAnchor, 10),
            right: (rightAnchor, 10),
            height: 30
        )
        
        addSubview(spinerView)
        spinerView.anchor(
            centerX: (posterImageView.centerXAnchor, 0),
            bottom: (posterImageView.bottomAnchor, 30)
        )
        
        addSubview(favoriteButton)
        favoriteButton.anchor(
            centerX: (posterImageView.centerXAnchor, 0),
            centerY: (posterImageView.centerYAnchor, 0)
        )
    }
    
    override func prepareForReuse() {
        favoriteButton = FavoriteButton()
        spinerView.startAnimating()
        posterImageView.image = ImageAssets.imgDefault1.image
        spinerView.hidesWhenStopped = true
        titleLabel.text = nil
    }
}
