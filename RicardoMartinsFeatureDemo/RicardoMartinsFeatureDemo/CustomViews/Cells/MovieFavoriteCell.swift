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
    fileprivate lazy var vStackView = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
    fileprivate lazy var hStackView = UIStackView(arrangedSubviews: [backdropImageView, vStackView])
    
    var favoriteButtonVM:FavoriteButtonVM! {
        didSet{
            bind()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func bind(){
        titleLabel.text = favoriteButtonVM.movie.value?.title
        overviewLabel.text = favoriteButtonVM.movie.value?.overview
        if let url = APIResourceEnum.image(path: favoriteButtonVM.movie.value?.backdrop_path, size: .w500).url{
            backdropImageView.sd_setImage(with: url, placeholderImage: Assets.DefaultsImages.imgDefault2.image, options: .continueInBackground){[weak self] (_, _, _, _) in
                self?.spinerView.stopAnimating()
            }
        }
    }
    
    fileprivate func setupView() {
        // hStackView
        addSubview(hStackView)
        hStackView.anchorFillSuperView(padding: 10)
        
        // spinerView
        addSubview(spinerView)
        spinerView.anchor(
            centerX: (backdropImageView.centerXAnchor, 0),
            centerY: (backdropImageView.centerYAnchor, 0)
        )
        
        // backdropImageView
        backdropImageView.anchor(width: UIScreen.main.bounds.width / 3.5)
    }
    
    fileprivate func configure(){
        // stacksViews
        vStackView.axis = .vertical
        hStackView.spacing = 10
        
        // spinerView
        spinerView.color = .black
        spinerView.startAnimating()
        spinerView.hidesWhenStopped = true
        
        // backdropImageView
        backdropImageView.contentMode = .scaleToFill
        backdropImageView.layer.cornerRadius = 5
        backdropImageView.clipsToBounds = true
       
        // titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        
        // overviewLabel
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        overviewLabel.textColor = .gray
        overviewLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        spinerView.isHidden = false
        spinerView.startAnimating()
        backdropImageView.image = Assets.DefaultsImages.imgDefault2.image
    }
    

}
