//
//  LodingViewController.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

class LodingViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showSpinner()
        SessionManager.shared.getInfo(success: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.presentView()
                self.hideSpinner()

            }
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.hideSpinner()
            
        }
    }
    
    func presentView() {
        
        
        let viewModel = MoviesListViewModel()

        let view = MovieListViewController(viewModel)
        viewModel.delegate = view
        
        let nav = UINavigationController()
        nav.viewControllers = [view]
        nav.title = "Popular"

        let viewModel1 = FavouriteViewModel()

        let view1 = MovieListViewController(viewModel1)
        viewModel1.delegate = view1
        let nav1 = UINavigationController()
        nav1.viewControllers = [view1]
        nav1.title = "Favorites"

        let tabBar = UITabBarController()
        tabBar.setViewControllers([nav,nav1], animated: true)
        self.present(tabBar, animated: true, completion: nil)


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
