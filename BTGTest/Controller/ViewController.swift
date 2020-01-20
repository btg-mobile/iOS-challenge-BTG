//
//  ViewController.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 11/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        present(MovieListViewController.instantiateFromXib(), animated: false)
    }


}

