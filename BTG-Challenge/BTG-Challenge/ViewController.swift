//
//  ViewController.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/16/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        print("Load")
        super.viewDidLoad()
        let tabBarController = UITabBarController()
        let movieVC = MovieViewController()
        let movieDetail = MovieDetailViewController()
        tabBarController.viewControllers = [movieVC, movieDetail]
        self.dismiss(animated: true) {
            self.present(tabBarController, animated: true) {
                       print("Loaded")
                   }
        }
       
       
        // Do any additional setup after loading the view.
    }
    


}

