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
    let favoriteButton = FavoriteButton(size: .init(width: 50, height: 50))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel:MovieDetailVM! {
        didSet{
            bind()
        }
    }
    
    func checkIsFavorited() {
        favoriteButton.favoriteButtonVM.checkIsFavorited()
    }
    
    fileprivate func bind(){
        favoriteButton.favoriteButtonVM = FavoriteButtonVM(movie: viewModel.movie.value)
        titleLabel.text = viewModel.movie.value?.title?.uppercased()
        yearLabel.text = viewModel.movie.value?.release_date?.components(separatedBy: "-")[0]
        if let url = APIResourceEnum.image(path: viewModel.movie.value?.poster_path, size: .original).url{
            posterImageView.sd_setImage(with: url, placeholderImage: Assets.DefaultsImages.imgDefault1.image, options: .continueInBackground) {[weak self] (_, _, _, _) in
                self?.spinerView.stopAnimating()
            }
        }
    }
    
    fileprivate func configure(){
        // self
        setShadow(color: .black, offset: .init(width: 2, height: 2), radius: 5, opacity: 0.6)
        
        // spinerView
        spinerView.color = .black
        spinerView.startAnimating()
        spinerView.hidesWhenStopped = true
        
        // yearLabel
        yearLabel.font = UIFont.boldSystemFont(ofSize: 20)
        yearLabel.textAlignment = .center
        yearLabel.textColor = .white
        yearLabel.backgroundColor = UIColor.darkText.withAlphaComponent(0.5)
        yearLabel.layer.cornerRadius = 5
        yearLabel.clipsToBounds = true
        
        // titleLabel
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // posterImageView
        posterImageView.image = Assets.DefaultsImages.imgDefault1.image
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 5
        posterImageView.clipsToBounds = true
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
        spinerView.isHidden = false
        spinerView.startAnimating()
        posterImageView.image = Assets.DefaultsImages.imgDefault1.image
    }
}
