//
//  FavoritesViewController.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    private var viewModel: FavoritesViewInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = FavoritesViewModel(view: self)
    }

}

extension FavoritesViewController: FavoritesViewOutput {

}
