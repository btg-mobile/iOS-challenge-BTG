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

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Setup

    private func setup() {
        title = viewModel.viewTitle
    }

}
