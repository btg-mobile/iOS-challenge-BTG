//
//  SplashViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 26/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: BaseViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var animatedImageView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //startAnimation(on: animatedImageView)
        print("Cheguei")
        // Do any additional setup after loading the view.
        //perform(#selector(showNavController), with: nil, afterDelay: 4)
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
