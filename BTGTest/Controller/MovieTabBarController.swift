//
//  MovieTabBarController.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 19/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import Foundation
import UIKit

class MovieTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        let firstViewController = MovieListViewController.instantiateFromXib()
                
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let secondViewController = MovieFavoriteViewController.instantiateFromXib()

        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let tabBarList = [firstViewController, secondViewController]

        viewControllers = tabBarList
    }

}
