//
//  ViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSplashView()
        startTimer()
        
    }
    
    fileprivate func loadSplashView() {
        
        let nibName = "SplashViewController"
        
        guard let splashVC = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? SplashViewController else {
            
            return
            
        }
        
        self.present(splashVC, animated: true)
        
    }
    
    private func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.endAnimation), userInfo: nil, repeats: false)
        
    }
    
    @objc func endAnimation() {
        
        dismiss(animated: false) {
            
            let identifier = "MainViewControllerIdentifier"
            
            self.timer.invalidate()
            
            let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            
            let homeVC = homeStoryboard.instantiateViewController(withIdentifier: identifier)
            
            self.present(homeVC, animated: false)
            
        }
        
    }
    
}
