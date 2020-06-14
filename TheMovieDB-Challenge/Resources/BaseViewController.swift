//
//  BaseViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 26/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func startAnimation(on uiview: AnimationView) {
        
        let name = "1961-movie-loading"
        let animation = Animation.named(name)
        uiview.animation = animation
        uiview.loopMode = .loop
        uiview.play()
        
    }
    
    func stopAnimation(on uiview: AnimationView) {
        uiview.stop()
        uiview.animation = nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
