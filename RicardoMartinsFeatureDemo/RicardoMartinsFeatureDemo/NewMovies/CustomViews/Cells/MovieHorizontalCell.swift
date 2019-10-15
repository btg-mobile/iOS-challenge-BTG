//
//  MovieHorizontalCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 13/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieHorizontalCell: UICollectionViewCell {
    fileprivate let spinerView = UIActivityIndicatorView(style: .whiteLarge)
    fileprivate let posterImageView = UIImageView()
    fileprivate let yearLabel = UILabel()
    fileprivate var favoriteButton = FavoriteButton(size: .init(width: 30, height: 30))
    
    var viewModel:MovieDetailVM! {
        didSet{
            bind()
            checkIsFavorited()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkIsFavorited(){
        favoriteButton.favoriteButtonVM.checkIsFavorited()
    }
    
    fileprivate func bind(){
        favoriteButton.favoriteButtonVM = FavoriteButtonVM(movie: viewModel.movie.value)
        yearLabel.text = viewModel?.movie.value?.release_date?.components(separatedBy: "-")[0]
        if let url = APIResourceEnum.image(path: viewModel?.movie.value?.poster_path, size: .original).url{
            posterImageView.sd_setImage(with: url, placeholderImage: Assets.DefaultsImages.imgDefault1.image, options: .continueInBackground) {[weak self] (_, _, _, _) in
                self?.spinerView.stopAnimating()
            }
        }
    }
    
    fileprivate func configure() {
        // self
        backgroundColor = .white
        layer.cornerRadius = 5
        setShadow(color: .black, offset: .init(width: 2, height: 2), radius: 5, opacity: 0.6)
        
        // posterImageView
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.image = Assets.DefaultsImages.imgDefault1.image
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 5
        posterImageView.clipsToBounds = true
        
        // yearLabel
        yearLabel.textColor = .white
        yearLabel.textAlignment = .center
        yearLabel.font = UIFont.boldSystemFont(ofSize: 14)
        yearLabel.setShadow(color: .black, offset: .init(width: 2, height: 2), radius: 5, opacity: 1)
        
        // spinerView
        spinerView.color = .black
        spinerView.startAnimating()
        spinerView.hidesWhenStopped = true
    }
    
    fileprivate func setupView(){
        // posterImageView
        addSubview(posterImageView)
        posterImageView.anchorFillSuperView()
        
        // yearLabel
        addSubview(yearLabel)
        yearLabel.anchor(
            top: (topAnchor, 5),
            left: (leftAnchor, 0),
            right: (rightAnchor, 0)
        )
        
        // spinerView
        addSubview(spinerView)
        spinerView.anchor(
            centerX: (centerXAnchor, 0),
            centerY: (centerYAnchor, 0)
        )
        
        // favoriteButton
        addSubview(favoriteButton)
        favoriteButton.anchor(
            right:(rightAnchor, 5),
            bottom: (bottomAnchor, 5)
        )
    }
    
    override func prepareForReuse() {
        favoriteButton.favoriteButtonVM.isFavorited.accept(false)
        spinerView.isHidden = false
        spinerView.startAnimating()
        posterImageView.image = Assets.DefaultsImages.imgDefault1.image
    }
}
