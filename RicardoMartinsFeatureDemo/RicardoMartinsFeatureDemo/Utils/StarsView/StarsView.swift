//
//  StarsView.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class StarsView: UIStackView {
    fileprivate var average: Double = 0
    fileprivate var size: CGFloat = 0
    
    convenience init(average: Double, size:CGFloat = 20){
        self.init()
        self.average = average
        self.size = size
        
        setupView()
    }
    
    func setupView() {
        spacing = 5
        anchor(height: size)
        
        let averageLabel = UILabel()
        averageLabel.text = "\(average)"
        averageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        averageLabel.textColor = UIColor(r: 214, g: 24, b: 42)
        averageLabel.anchor(width: 35)
        addArrangedSubview(averageLabel)
        
        for i in 1...5 {
            let iconImageView = UIImageView(image: ImageAssets.iconStar.image.withRenderingMode(.alwaysTemplate))
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
