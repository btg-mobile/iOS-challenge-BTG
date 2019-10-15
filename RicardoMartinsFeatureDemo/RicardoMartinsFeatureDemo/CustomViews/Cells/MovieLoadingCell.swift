//
//  MovieLoadingCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 14/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import Lottie

class MovieLoadingCell: UICollectionViewCell {
    fileprivate let aniLoadingView = AnimationView(name: Assets.Animations.aniLoading.animation)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configure() {
        aniLoadingView.play()
        aniLoadingView.loopMode = .loop
    }
    
    fileprivate func setupView() {
        addSubview(aniLoadingView)
        aniLoadingView.anchorFillSuperView(padding: 20)
    }
}
