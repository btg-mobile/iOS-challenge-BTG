//
//  FavoritesViewController.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet private weak var favoritesTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var contentView: UIView!

    private var viewModel: FavoritesViewInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = FavoritesViewModel(view: self)
    }

}

extension FavoritesViewController: FavoritesViewOutput {

}
