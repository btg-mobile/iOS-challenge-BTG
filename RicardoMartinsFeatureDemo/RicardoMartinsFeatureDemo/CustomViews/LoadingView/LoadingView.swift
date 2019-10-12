//
//  LoadingView.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class LoadingView:UIView {
    fileprivate let backgroundView = UIView(backgroundColor: .black)
    fileprivate let containerSpinnerView = UIView(backgroundColor: .white)
    
    fileprivate convenience init() {
        self.init(frame: Helper().getFullScreenFrame())
        setup()
        animate()
    }
    
    fileprivate func setup() {
        setupBackGround()
        setupContainerSpinner()
        setupSpinner()
    }
    
    fileprivate func animate() {
        animateBackground()
        animateContainerSpinner()
    }
    
    fileprivate func setupBackGround() {
        addSubview(backgroundView)
        backgroundView.anchorFillSuperView()
    }
    
    fileprivate func setupContainerSpinner() {
        containerSpinnerView.layer.cornerRadius = 10
        addSubview(containerSpinnerView)
        
        containerSpinnerView.anchor(
            centerX: (centerXAnchor, 0),
            centerY: (centerYAnchor, 0),
            width: 80,
            height: 80
        )
        
        containerSpinnerView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    fileprivate func setupSpinner() {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = .black
        containerSpinnerView.addSubview(spinner)
        
        spinner.anchor(
            centerX: (centerXAnchor, 0),
            centerY: (centerYAnchor, 0)
        )
        
        spinner.startAnimating()
    }
    
    fileprivate func animateBackground() {
        backgroundView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.backgroundView.alpha = 0.3
        })
    }
    
    fileprivate func animateContainerSpinner() {
        containerSpinnerView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 12, options: .curveEaseOut, animations: {
            self.containerSpinnerView.alpha = 1
            self.containerSpinnerView.transform = .identity
        })
    }
    
    static func show() {
        UIApplication.shared.keyWindow?.addSubview(LoadingView())
    }
    
    static func hide() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.subviews.forEach { (view) in
            if let hud = view as? LoadingView{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    hud.alpha = 0
                    hud.containerSpinnerView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }) { ( _ ) in
                    hud.removeFromSuperview()
                }
            }
        }
    }
}
