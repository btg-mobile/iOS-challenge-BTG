//
//  UIImage+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 11/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

enum Assets {
    enum Icons: String {
        case iconBack = "icon-back"
        case iconFavoriteStyle = "icon-favorite-style"
        case iconFavoriteFlat = "icon-favorite-flat"
        case iconMovie = "icon-movie"
        case iconStar = "icon-star"
        case iconAbout = "icon-about"
        
        var image: UIImage {
            return UIImage(named: rawValue) ?? UIImage()
        }
    }
    
    enum Animations: String {
        case aniLaunchMovies = "animation-launch-movies"
        case aniNoResults = "animation-no-results"
        
        var animation: String {
            return rawValue
        }
    }
    
    enum DefaultsImages: String {
        case imgDefault1 = "img-default-1"
        case imgDefault2 = "img-default-2"
        
        var image: UIImage {
            return UIImage(named: rawValue) ?? UIImage()
        }
    }
}
