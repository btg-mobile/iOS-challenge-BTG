//
//  MovieRouter.swift
//  MovieApp
//
//  Created by Lucas Moraes on 14/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit

class MovieRouter: NSObject {
    
    var presenter: MovieDetailPresenterProtocol?
    
    func goToDetail(showing movie: Movie, thumb: UIImage, from viewController: MovieViewController, to detail: MovieDetailViewController) {
        detail.display(movie: movie, thumb: thumb)
        viewController.navigationController?.pushViewController(detail, animated: true)
    }
    
    func goToDetailFavorite(showing movie: FavoriteMovie, from viewController: FavoriteViewController, to detail: MovieDetailViewController) {
        detail.displayFavorite(movie: movie)
        viewController.navigationController?.pushViewController(detail, animated: true)
    }
    
}
