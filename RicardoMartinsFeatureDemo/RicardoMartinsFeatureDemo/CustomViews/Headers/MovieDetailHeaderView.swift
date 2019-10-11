//
//  MovieDetailHeaderView.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class MovieDetailHeaderView: UIView {
    fileprivate let titleLabel = UILabel()
    fileprivate let spinerView = UIActivityIndicatorView(style: .whiteLarge)
    fileprivate let backdropImageView = UIImageView()
    fileprivate let posterImageView = UIImageView()
    fileprivate let translucidView = UIView()
    
    let backButton = UIButton(type: .system)
    lazy var favoriteButton = FavoriteButton(movie: viewModel.movie.value)
    
    var viewModel:MovieDetailVM! {
        didSet{
            setupView()
            setupImagesAnimation()
        }
    }
    
    fileprivate func setupImagesAnimation(){
        if let url = APIResourceEnum.image(path: viewModel.movie.value?.poster_path, size: .original).url{
            posterImageView.sd_setImage(with: url, placeholderImage: ImageAssets.imgDefault1.image, options: .continueInBackground)
        }
        
        if let url = APIResourceEnum.image(path: viewModel.movie.value?.backdrop_path ?? viewModel.movie.value?.poster_path, size: .w500).url{
            backdropImageView.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground) {[weak self] (_, _, _, _) in
                guard let self = self else { return }
                self.backdropImageView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 100, 0, 0)
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                    guard let self = self else { return }
                    self.spinerView.stopAnimating()
                    self.backdropImageView.layer.transform = CATransform3DIdentity
                })
                
                UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                    guard let self = self else { return }
                    self.translucidView.alpha = 1
                })
            }
        }else{
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                guard let self = self else { return }
                self.spinerView.stopAnimating()
                self.backdropImageView.image = ImageAssets.imgDefault2.image
                self.backdropImageView.alpha = 1
                self.translucidView.alpha = 1
            })
        }
    }
    fileprivate func setupView(){
        // Self
        tintColor = .white
        
        // backdropImageView
        addSubview(backdropImageView)
        backdropImageView.clipsToBounds = true
        backdropImageView.anchorFillSuperView(topSafeArea: false)
        
        if(viewModel.movie.value?.vote_average == nil && viewModel.movie.value?.genre_ids == nil){
            backdropImageView.contentMode = .scaleAspectFit
        }else{
            backdropImageView.contentMode = .scaleAspectFill
        }
        
        // translucidView
        addSubview(translucidView)
        translucidView.alpha = 0
        translucidView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        translucidView.anchorFillSuperView(topSafeArea: false)
        
        // posterImageView and shadowPosterImageView
        let widthRelative = UIScreen.main.bounds.width / 3
        let heightRelative = widthRelative * 1.4
        let bottomRelative = -heightRelative / 2
        
        // posterImageView
        addSubview(posterImageView)
        posterImageView.setShadow(color: .black, offset: .init(width: 2, height: 2), radius: 5, opacity: 0.6)
        posterImageView.backgroundColor = .red
        posterImageView.image = ImageAssets.imgDefault1.image
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 5
        posterImageView.anchor(
            left: (leftAnchor, 20),
            bottom: (bottomAnchor, bottomRelative),
            width: widthRelative,
            height: heightRelative
        )
        
        // backButton
        addSubview(backButton)
        backButton.setImage(ImageAssets.iconBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.anchor(
            top: (topAnchor, 50),
            left: (leftAnchor, 0),
            width: 50,
            height: 50
        )
        
        // titleLabel
        addSubview(titleLabel)
        titleLabel.text = viewModel.movie.value?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 3
        titleLabel.anchor(
            top: (topAnchor, 55),
            left: (backButton.rightAnchor, 30),
            right: (rightAnchor, 30)
        )
        
        // spinerView
        addSubview(spinerView)
        spinerView.color = .black
        spinerView.startAnimating()
        spinerView.anchor(
            centerX: (centerXAnchor, 0),
            bottom: (bottomAnchor, 40)
        )
        
        // favoriteButton
        addSubview(favoriteButton)
        favoriteButton.anchor(
            right: (rightAnchor, 30),
            bottom: (bottomAnchor, 30)
        )
    }
}


