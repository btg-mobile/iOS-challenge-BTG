//
//  FavouritesViewController.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    private var viewModel: FavouritesViewInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = FavouritesViewModel(view: self)
    }

}

extension FavouritesViewController: FavouritesViewOutput {

}
