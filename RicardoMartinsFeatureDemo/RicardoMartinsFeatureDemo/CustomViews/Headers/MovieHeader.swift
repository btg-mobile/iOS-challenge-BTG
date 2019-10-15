//
//  MovieHeader.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 14/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {
    fileprivate let sectionLabel = UILabel()
    let movieHeaderHorizontalVC  = MovieHeaderHorizontalVC()
    
    var header:Header!{
        didSet{
            bind()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
    }
    
    fileprivate func bind(){
        sectionLabel.text = header.info?.title
        movieHeaderHorizontalVC.viewModel = MovieHorizontalVM(header: header)
    }
    
    fileprivate func configure() {
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sectionLabel.numberOfLines = 1
    }
    
    fileprivate func setupView() {
        // sectionLabel
        addSubview(sectionLabel)
        sectionLabel.anchor(
            top: (topAnchor, 5),
            left: (leftAnchor, 15),
            right: (rightAnchor, 0)
        )
        
        // containerStackView
        addSubview(movieHeaderHorizontalVC.view)
        movieHeaderHorizontalVC.view.anchor(
            top: (sectionLabel.bottomAnchor, 10),
            left: (leftAnchor, 0),
            right: (rightAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
