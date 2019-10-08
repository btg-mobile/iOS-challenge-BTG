//
//  UIViewController+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func didPop(){
        navigationController?.popViewController(animated: true)
    }
}
