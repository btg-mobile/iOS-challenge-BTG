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
        setupViewControllers()
        setupUI()
    }
    
    fileprivate func setupUI(){
        UINavigationBar.appearance().prefersLargeTitles = true
        tabBar.tintColor = .black
    }
    
    fileprivate func setupViewControllers() {
        viewControllers = [
            setupNavController(for: MovieVC(viewModel: MovieVM()), title: String.Localizable.app.getValue(code: 2), icon: Assets.Icons.iconMovie.image),
            setupNavController(for: MovieSearchVC(viewModel: MovieSearchVM()), title: String.Localizable.app.getValue(code: 18), icon: Assets.Icons.iconSearch.image),
            setupNavController(for: MoviesFavoriteVC(viewModel: FavoriteVM()), title: String.Localizable.app.getValue(code: 3), icon: Assets.Icons.iconFavoriteFlat.image),
            setupNavController(for: WebPageVC(page: .ricardoMartins), title: String.Localizable.app.getValue(code: 11), icon: Assets.Icons.iconAbout.image),
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