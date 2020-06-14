//
//  Utils.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 19/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

///Global Notification Keys
let notificationKeyPopular = "home.movies.popular"
let notificationKeyNowPlaying = "home.movies.nowPlaying"
let notificationKeyUpcoming = "home.movies.upComing"
let notificationKeyTopRated = "home.movies.topRated"

func instantiateView(named view: String, fromStoryboard storyboard: String) -> UIViewController {
    return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: view)
}
