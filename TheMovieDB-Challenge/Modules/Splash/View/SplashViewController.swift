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
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startTimer()
        startAnimation()
        
    }
    
    private func startAnimation() {
        lottieStartAnimation(on: animatedImageView, animationFileName: .movieLoading1)
    }
    
    private func startTimer() {
        
        let timeInterval = 1.0//5.0
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.endAnimation), userInfo: nil, repeats: false)
        
    }
    
    @objc func endAnimation() {
        
        lottieStopAnimation(on: animatedImageView)
        timer.invalidate()
        
        DispatchQueue.main.async {
            UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                
                let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                
                let homeVC = homeStoryboard.instantiateInitialViewController()
                
                self.present(homeVC!, animated: false, completion: nil)
                
            })
        }
    }
    
}
