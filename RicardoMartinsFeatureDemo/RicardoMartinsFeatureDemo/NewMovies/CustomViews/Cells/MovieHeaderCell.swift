//
//  MovieHeaderCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 14/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieHeaderCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        
    }
    
    fileprivate func configure() {
        backgroundColor = .purple
    }
}
