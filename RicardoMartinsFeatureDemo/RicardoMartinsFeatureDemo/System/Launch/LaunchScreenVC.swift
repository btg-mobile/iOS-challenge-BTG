//
//  LaunchScreenVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreen: UIViewController {
    lazy var stackView = UIStackView(arrangedSubviews: [
        setupLabel(text: "Feature Demo"),
        AnimationView(name: "launch-movies"),
        setupLabel(text: "Ricardo Martins")
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        animate()
    }
    
    fileprivate func setupViews(){
        view.addSubview(stackView)
        view.backgroundColor = .white
        stackView.axis = .vertical
        stackView.anchorFillSuperView(padding: 40)
        stackView.distribution = .equalCentering
    }
    
    fileprivate func setupLabel(text:String) -> UILabel{
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0
        return label
    }
    
    fileprivate func animate(){
        let header = stackView.arrangedSubviews[0] as! UILabel
        let body = stackView.arrangedSubviews[1] as! AnimationView
        let footer = stackView.arrangedSubviews[2] as! UILabel
        
        body.play()
        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseOut, animations: {
            header.alpha = 1
            footer.alpha = 1
        }) { ( _ ) in
            UIView.animate(withDuration: 1, delay: 4, options: .curveEaseOut, animations: {
                header.alpha = 0
                body.alpha = 0
                footer.alpha = 0
            }) { ( _ ) in
                UIApplication.shared.keyWindow?.rootViewController = MainTabBarVC()
            }
        }
    }
}
