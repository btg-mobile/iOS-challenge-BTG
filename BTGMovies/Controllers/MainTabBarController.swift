//
//  MainTabBarController.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let moviesIcon = #imageLiteral(resourceName: "movies-tab-icon")
    private let favoritesIcon = #imageLiteral(resourceName: "favorites-tab-icon")
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let moviesVC = UINavigationController(rootViewController: MoviesViewController(viewModel: MoviesViewModel(screenType: .popular)))
        moviesVC.tabBarItem = UITabBarItem(title: "filmes", image: moviesIcon, selectedImage: moviesIcon)
        
        let favoritesVC = UINavigationController(rootViewController: MoviesViewController(viewModel: MoviesViewModel(screenType: .favorites)))
        favoritesVC.tabBarItem = UITabBarItem(title: "favoritos", image: favoritesIcon, selectedImage: favoritesIcon)
        
        self.viewControllers = [moviesVC, favoritesVC]
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = .red
        self.tabBar.isTranslucent = false
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
