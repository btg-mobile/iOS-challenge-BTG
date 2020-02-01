//
//  TabBarRootController.swift
//  TheMovieDB
//
//  Created by Usuario on 28/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import UIKit

enum TabBarRootController {

    case movies
    case favorites

    static let all: [TabBarRootController] = [.movies, .favorites]
}

extension TabBarRootController {

    func instance() -> UIViewController {
        switch self {
        case .movies:
            return AppStoryboard.movies.initialViewController()!
        case .favorites:
            return AppStoryboard.favorites.initialViewController()!
        }
    }
}
