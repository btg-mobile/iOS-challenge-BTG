//
//  NoResultsAnimationView.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import Lottie

class NoResultsAnimationView: UIView {
    fileprivate let animationView = AnimationView(name: Assets.Animations.aniNoResults.animation)
    fileprivate let titleLabel = UILabel()
    
    enum TypeEnum {
        case noResultsInSearch
        case favoriteIsEmpty
        
        func getString() -> String {
            switch self {
            case .noResultsInSearch:
                return String.Localizable.app.getValue(code: 9)
            case .favoriteIsEmpty:
                return String.Localizable.app.getValue(code: 10)
            }
        }
    }
    
    override var isHidden: Bool {
        didSet{
            if(!isHidden){
                animationView.play()
            }else{
                animationView.stop()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setText(type: NoResultsAnimationView.TypeEnum){
        titleLabel.text = type.getString()
    }
    
    fileprivate func setupView() {
        // self
        isUserInteractionEnabled = false
        
        // animationView
        animationView.loopMode = .loop
        addSubview(animationView)
        
        animationView.anchor(
            centerX: (centerXAnchor, 0),
            top: (topAnchor, 40),
            width: 100,
            height: 100
        )
        
        // titleLabel
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .gray
        addSubview(titleLabel)
        
        titleLabel.anchor(
            centerX: (centerXAnchor, 0),
            top: (animationView.bottomAnchor, 20),
            width: 250
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

