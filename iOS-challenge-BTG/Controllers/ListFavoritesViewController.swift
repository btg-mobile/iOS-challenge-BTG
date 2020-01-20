//
//  ListFavoritesViewController.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

class ListFavoritesViewController: UIViewController {

    private var viewModel = ListFavoritesViewModel()

    // MARK: - Object lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup

    private func setup() {
        title = viewModel.viewTitle
    }

}
