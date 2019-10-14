//
//  RatingView.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class RatingView: UIStackView {
    fileprivate let averageLabel = UILabel()
    
    fileprivate var size: CGFloat = 0
    
    var average: Double = 0{
        didSet{
            bind()
        }
    }

    convenience init(size:CGFloat){
        self.init()
        self.size = size
        setupView()
    }
    
    fileprivate func bind(){
        averageLabel.text = "\(average)"
        configureAvarage()
    }
    
    fileprivate func setupView() {
        // self
        spacing = 5
        anchor(height: size)
        
        // averageLabel
        averageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        averageLabel.textColor = UIColor(r: 214, g: 24, b: 42)
        averageLabel.anchor(width: 35)
        addArrangedSubview(averageLabel)
    }
    
    fileprivate func configureAvarage(){
        for i in 1...5 {
            let iconImageView = UIImageView(image: Assets.Icons.iconStar.image.withRenderingMode(.alwaysTemplate))
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.anchor(width: size)
            
            let stars = Int(average / 2)

            if(i <= stars){
                iconImageView.tintColor = UIColor(r: 214, g: 24, b: 42)
            }else{
                iconImageView.tintColor = UIColor(r: 210, g: 210, b: 210)
            }
            addArrangedSubview(iconImageView)
        }
        addArrangedSubview(UIView())
    }
}

