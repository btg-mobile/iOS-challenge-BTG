//
//  MovieListViewController.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

// MARK: - MovieListViewController
class MovieListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var moviesTableView: UITableView!

    // MARK: - View Model
    private var viewModel: MovieListViewInput!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieListViewModel(view: self)

        loadTableView()

        viewModel.fetchMovieList()
    }

    private func loadTableView() {
        moviesTableView
            .register(UINib(nibName: "MovieListTableViewCell", bundle: nil),
                      forCellReuseIdentifier: "movieListCell")

        moviesTableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }

        let movie = viewModel.movie(at: indexPath.row)
        cell.fill(movie: movie)

        return cell
    }
}

// MARK: - MovieListViewOutput
extension MovieListViewController: MovieListViewOutput {
    func reloadMovieTableView() {
        moviesTableView.reloadData()
    }
}
