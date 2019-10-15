//
//  AppDelegate+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import SDWebImage

extension AppDelegate {
    func setupApp() -> Bool{
        window = UIWindow()
        window?.rootViewController = LaunchScreen()
        window?.makeKeyAndVisible()
        MovieDetailVM().getGenres()
        return true
    }
}
