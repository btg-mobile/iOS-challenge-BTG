//
//  LoadingViewable.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

protocol LoadingViewable {
    func startAnimating()
    func stopAnimating()
}

extension LoadingViewable where Self : UIViewController {
    func startAnimating(){
        LoadingView.show()
    }
    
    func stopAnimating() {
        LoadingView.hide()
    }
}
