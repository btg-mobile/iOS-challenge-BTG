//
//  UIImageView+Extensions.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(path: String) {
        MovieServiceAPI.shared.getImage(path: path) { result in
            if case .success(let image) = result {
                self.image = image
            }
        }
    }
}
