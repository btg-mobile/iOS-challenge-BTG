//
//  UIImageView+URL.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromURL(_ url: URL?) {
        self.image = nil
        var activityIndicator: UIActivityIndicatorView!

        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        activityIndicator.hidesWhenStopped = true

        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        if let imageURL = url {
            self.contentMode = .scaleAspectFit
            activityIndicator.startAnimating()
            self.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                activityIndicator.stopAnimating()
            }
        } else {
            self.contentMode = .scaleToFill
            self.image = UIImage(named: "emptyPoster")
        }
    }
}
