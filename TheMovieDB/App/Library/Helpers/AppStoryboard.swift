//
//  AppStoryboard.swift
//  TheMovieDB
//
//  Created by Usuario on 28/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard: String {

    case movies
    case favorites
    case detail

    var name: String {
        return self.rawValue.firstUppercased
    }
}

extension AppStoryboard {

    var instance: UIStoryboard {
        return UIStoryboard(name: self.name, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(
        viewControllerClass: T.Type,
        function: String = #function,
        line: Int = #line,
        file: String = #file) -> T {

        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID

        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError(
                """
                ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.
                File : \(file)
                Line Number : \(line)
                Function : \(function)
                """
            )
        }

        return scene
    }

    func initialViewController() -> UIViewController? {

        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {

    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {

        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
