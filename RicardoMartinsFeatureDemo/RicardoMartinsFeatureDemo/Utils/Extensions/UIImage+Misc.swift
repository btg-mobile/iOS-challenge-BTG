//
//  UIImage+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 11/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

enum ImageAssets: String {
    case iconBack = "icon-back"
    case iconFavoriteStyle = "icon-favorite-style"
    case iconFavoriteFlat = "icon-favorite-flat"
    case iconMovie = "icon-movie"
    case iconStar = "icon-star"
    case imgDefault1 = "img-default-1"
    case imgDefault2 = "img-default-2"

    var image: UIImage {
        return UIImage(asset: self)
    }
}

extension UIImage {
    convenience init!(asset: ImageAssets) {
        self.init(named: asset.rawValue)
    }
}
