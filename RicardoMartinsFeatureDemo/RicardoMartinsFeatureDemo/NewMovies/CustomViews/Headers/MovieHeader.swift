//
//  MovieHeader.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 14/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {
    let movieHeaderHorizontalVC  = MovieHeaderHorizontalVC()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView() {
        addSubview(movieHeaderHorizontalVC.view)
        movieHeaderHorizontalVC.view.anchorFillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
