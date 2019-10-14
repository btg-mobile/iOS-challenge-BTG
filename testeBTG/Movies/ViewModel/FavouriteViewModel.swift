//
//  FavouriteViewModel.swift
//  testeBTG
//
//  Created by pc on 14/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

class FavouriteViewModel {
    var movieList: [Movie] = []
    var showingList: [Movie] = []
    weak var delegate: MoviesListViewModelDelegate?
    init() {}
    
}
extension FavouriteViewModel: MoviesListViewModelProtocol {
    func didReceiveMemoryWarning() {
        
    }
    func getNextPage() {
        self.delegate?.finishedEmptyRequest()
    }
    func getPreviousPage() {
        self.delegate?.finishedEmptyRequest()
    }
    
    func getMoviesList(_ text: String) {
        
        self.movieList = SessionManager.shared.getAllFavourites().map({ (fav) -> Movie in
            let temp = Movie(posterPath: fav.posterPath, movieId: Int(fav.movieId ), originalTitle: fav.originalTitle, genreIds: fav.genreIds?.map({
                $0.intValue
            }), voteAverage: fav.voteAverage, overview: fav.overview, releaseDate: fav.releaseDate)
            return temp
        })
        
        if text != "" {
            let filtered = movieList.filter {
                $0.originalTitle?.lowercased().contains(text.lowercased()) ?? false
            }
            showingList = filtered
        }else {
            showingList = movieList
        }
        
        self.delegate?.viewModelListChanged(self)

    }

    func numberOfRows() -> Int {
        return showingList.count
    }
    
    func movieForIndex(_ index: Int) -> Movie? {
        
        return showingList[index]
    }
}
