//
//  MainTabBarVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieDetailVM().getGenres() // Just to advance the search in the API of the list of movie genres that will be persisted locally.
        setupViewControllers()
        setupUI()
    }
    
    fileprivate func setupUI(){
        UINavigationBar.appearance().prefersLargeTitles = true
        tabBar.tintColor = .black
    }
    
    fileprivate func setupViewControllers() {
        viewControllers = [
            setupNavController(for: MoviesPopularVC(viewModel: MovieVM()), title: "Filmes", icon: UIImage(named: "icon-movie") ?? UIImage()),
            setupNavController(for: MoviesFavoriteVC(viewModel: FavoriteVM()), title: "Favoritos", icon: UIImage(named: "icon-favorite") ?? UIImage()),
        ]
    }
    
    fileprivate func setupNavController(for rootVC: UIViewController, title: String, icon: UIImage) -> UIViewController {
        let nav = UINavigationController(rootViewController: rootVC)
        rootVC.navigationItem.title = title
        nav.navigationBar.tintColor = .black
        nav.tabBarItem.title = title
        nav.tabBarItem.image = icon
        return nav
    }
}
