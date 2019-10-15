//
//  MovieHeaderCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 14/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieHeaderCell : UICollectionViewCell {
    fileprivate let spinerView = UIActivityIndicatorView(style: .whiteLarge)
    fileprivate let overviewLabel = UILabel()
    fileprivate let titleLabel = UILabel()
    fileprivate let backdropImageView = UIImageView()
    
    fileprivate lazy var containerStackView = UIStackView(arrangedSubviews: [
        titleLabel, overviewLabel, backdropImageView
    ])
    
    var viewModel:MovieDetailVM! {
        didSet{
            bind()
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
    
    fileprivate func bind(){
        titleLabel.text = viewModel?.movie.value?.title
        overviewLabel.text = viewModel?.movie.value?.overview
        if let url = APIResourceEnum.image(path: viewModel?.movie.value?.backdrop_path, size: .original).url{
            backdropImageView.sd_setImage(with: url, placeholderImage: Assets.DefaultsImages.imgDefault1.image, options: .continueInBackground) {[weak self] (_, _, _, _) in
                self?.spinerView.stopAnimating()
            }
        }
    }
    
    fileprivate func makeInfoText() -> NSMutableAttributedString {
        let infoAttributedString = NSMutableAttributedString(string: "")
        
        if let popularity = viewModel.movie.value?.popularity {
            let popularity = NSMutableAttributedString(
                string:  "\(popularity) \(String.Localizable.app.getValue(code: 8))",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)
                ]
            )
            
            infoAttributedString.append(popularity)
        }
        
        infoAttributedString.append(NSMutableAttributedString(string: "\n"))
        
        let genres = NSMutableAttributedString(
            string:  "\(viewModel.genres.value.map { $0.name ?? "" }.joined(separator:", "))",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)
            ]
        )
        
        infoAttributedString.append(genres)
        return infoAttributedString
    }
    
    fileprivate func setupView() {
        addSubview(containerStackView)
        containerStackView.anchor(
            left: (leftAnchor, 0),
            right: (rightAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
        
        // backdropImageView
        var backdropImageViewHeight:CGFloat = 0
        
        switch UIDevice.screenType {
        case .iPhones_X_XS:
            backdropImageViewHeight = frame.height * 0.71
        case .iPhones_6Plus_6sPlus_7Plus_8Plus, .iPhone_XR, .iPhone_XSMax:
            backdropImageViewHeight = frame.height * 0.74
        case .iPhones_6_6s_7_8:
            backdropImageViewHeight = frame.height * 0.72
        case .iPhones_4_4S, .iPhones_5_5s_5c_SE:
            backdropImageViewHeight = frame.height * 0.65
        default:
            backdropImageViewHeight = frame.height * 0.65
        }
        
        backdropImageView.anchor(height: backdropImageViewHeight)
        
        // spinerView
        addSubview(spinerView)
        spinerView.anchor(
            centerX: (backdropImageView.centerXAnchor, 0),
            centerY: (backdropImageView.centerYAnchor, 0)
        )
    }
    
    fileprivate func configure() {
        // self
        backgroundColor = .white
        
        // containerStackView
        containerStackView.axis = .vertical
        containerStackView.spacing = 5
        
        // titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 1
        
        // spinerView
        spinerView.color = .black
        spinerView.startAnimating()
        spinerView.hidesWhenStopped = true
        
        // overviewLabel
        overviewLabel.numberOfLines = 2
        overviewLabel.textColor = .darkGray
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        
        // backdropImageView
        backdropImageView.image = Assets.DefaultsImages.imgDefault1.image
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.layer.cornerRadius = 5
        backdropImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        backdropImageView.image = Assets.DefaultsImages.imgDefault2.image
        spinerView.isHidden = false
        spinerView.startAnimating()
    }
}
