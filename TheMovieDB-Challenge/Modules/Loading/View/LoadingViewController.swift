//
//  ViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 19/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var parentindicator: UIView!
}

class LoadingView {
    
    static let sharedInstance = LoadingView()
    private(set) var isLoading = false
    private var loadingViewcontroller: LoadingViewController!
    
    private init() {
        loadingViewcontroller = instantiateView(named: "LoadingView", fromStoryboard: "Loading") as? LoadingViewController
        loadingViewcontroller.view.alpha = 0.0
    }
    
    private func instantiateView(named view: String, fromStoryboard storyboard: String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: view)
    }
    
    func show(style: UIBlurEffect.Style = .dark) {
        self.loadingViewcontroller.modalTransitionStyle   = .crossDissolve
        self.loadingViewcontroller.modalPresentationStyle = .overFullScreen
        
        if isLoading { return }
        
        isLoading = true
        if let keyWindow = UIApplication.shared.windows.last { ///KeyWindow deprecated
            DispatchQueue.main.async {
                keyWindow.addSubview(self.loadingViewcontroller.view)
                UIView.animate(withDuration: 0.3, animations: {
                    self.loadingViewcontroller.view.alpha = 1
                })
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingViewcontroller.view.alpha = 0
            }) { (finish) in
                if finish {
                    self.isLoading = false
                    self.loadingViewcontroller.view.removeFromSuperview()
                }
            }
        }
    }
    
}
