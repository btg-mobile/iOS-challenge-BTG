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
    fileprivate let animationView = AnimationView(name: "no-results")
    fileprivate let titleLabel = UILabel()
    
    enum TypeEnum:String {
        case noResultsInSearch = "Desculpe! Não encontramos resultados para a sua busca."
        case favoriteIsEmpty = "Você ainda não possui filmes favoritos."
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
        titleLabel.text = type.rawValue
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

