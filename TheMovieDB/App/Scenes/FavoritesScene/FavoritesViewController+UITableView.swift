//
//  FavoritesViewController+UITableView.swift
//  TheMovieDB
//
//  Created by Usuario on 31/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import UIKit

extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      if filteredMovies.count > 0 {
        let request = FavoritesScene.SelectMovie.Request(movie: filteredMovies[indexPath.row])
        interactor?.selectMovie(request: request)
      }
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieTableViewCell.self)", for: indexPath)
        guard let movieCell = cell as? MovieTableViewCell else {
            fatalError("Could not deque cell \(MovieTableViewCell.self)")
        }
        let movie = filteredMovies[indexPath.row]
        movieCell.movieLabel.text = movie.value(forKey: "title") as? String ?? ""
        movieCell.dateLabel.text = movie.value(forKey: "releaseDate") as? String ?? ""
        let url = URL(string: "\(EnviromentURL.imageURL.baseURL)\(String(describing: movie.value(forKey: "posterPath") as? String ?? ""))")!
        movieCell.movieImageView.load(url: url )
        return movieCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
}
