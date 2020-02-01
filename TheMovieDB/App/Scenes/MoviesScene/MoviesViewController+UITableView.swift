//
//  MoviesViewController+UITableView.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import UIKit

extension MoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      if filteredMovies.count > 0 {
        let request = MoviesScene.SelectMovie.Request(movie: filteredMovies[indexPath.row])
        interactor?.selectMovie(request: request)
      }
    }
}

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieTableViewCell.self)", for: indexPath)
        guard let movieCell = cell as? MovieTableViewCell else {
            fatalError("Could not deque cell \(MovieTableViewCell.self)")
        }
        let movie = filteredMovies[indexPath.row]
        movieCell.movieLabel.text = movie.title
        movieCell.dateLabel.text = movie.releaseDate
        if let path = movie.posterPath, let url = URL(string: "\(EnviromentURL.imageURL.baseURL)\(path)")
        {
          movieCell.movieImageView.load(url: url )
        }
        
        return movieCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
}
