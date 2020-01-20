//
//  ListMoviesViewController.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

class ListMoviesViewController: UIViewController {

    private var viewModel = ListMoviesViewModel()

    @IBOutlet private weak var moviesView: MoviesView!
    
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
        fetchMovies()
    }

    // MARK: - Setup

    private func setup() {
        title = viewModel.viewTitle
    }

    // MARK: - Display

    func fetchMovies() {
        viewModel.fetchPopularMovies { (movieViewModel) in
            DispatchQueue.main.async {
                self.moviesView.movies = movieViewModel.movies
                self.moviesView.collectionView.reloadData()
            }
        }
    }
}
