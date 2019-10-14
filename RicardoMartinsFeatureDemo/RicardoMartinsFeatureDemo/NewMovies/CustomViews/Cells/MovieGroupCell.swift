//
//  MovieGroupCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 13/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieGroupCell: UICollectionViewCell {
    fileprivate let sectionLabel = UILabel()
    var movieHorizontalVC = MovieHorizontalVC()
    
    var section:Section!{
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
        sectionLabel.text = section.info.title
        movieHorizontalVC.viewModel = MovieHorizontalVM(section: section)
    }
    
    fileprivate func configure() {
        backgroundColor = .white
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }

    fileprivate func setupView() {
        // sectionLabel
        addSubview(sectionLabel)
        sectionLabel.anchor(
            top: (topAnchor, 0),
            left: (leftAnchor, 15),
            right: (rightAnchor, 0)
        )
        
        // movieHorizontalVC
        addSubview(movieHorizontalVC.view)
        movieHorizontalVC.view.anchor(
            top: (sectionLabel.bottomAnchor, 0),
            left: (leftAnchor, 0),
            right: (rightAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
    }
//    
//    override func prepareForReuse() {
//        movieHorizontalVC = MovieHorizontalVC()
//    }
}
