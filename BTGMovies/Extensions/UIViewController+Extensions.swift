//
//  UIViewController+Extensions.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

private var activityIndicatorView: UIView = UIView()

private var activityIndicator: CustomActivityIndicator = {
    let image = #imageLiteral(resourceName: "activity_indicator")
    return CustomActivityIndicator(image: image, size: image.size.width, difFrame: 0)
}()

extension UIViewController {
    func showActivityIndicator() {
        activityIndicatorView.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100)
        activityIndicatorView.backgroundColor = UIColor.clear
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        blurView.frame = activityIndicatorView.bounds
        blurView.layer.cornerRadius = 20
        blurView.clipsToBounds = true
        
        blurView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurView.center
        activityIndicatorView.addSubview(blurView)
        
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.tag = 1
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
    }
    
    func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        for subview in self.view.subviews where subview.tag == 1 {
            subview.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func setupNavigationLargeTitle(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setupNavigationBack() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func showAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
