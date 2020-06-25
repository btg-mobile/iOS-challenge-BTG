//
//  SplashViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 26/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var animatedImageView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.lottieStartAnimation(on: animatedImageView, animationFileName: .movieLoading1)
        print("###################a")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
