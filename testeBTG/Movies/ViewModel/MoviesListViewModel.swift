//
//  MoviesListViewModel.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

protocol MoviesListViewModelDelegate: AnyObject{
    func viewModelListChanged(_ viewModel: MoviesListViewModelProtocol)
    func viewModelReceivedError(_ viewModel: MoviesListViewModelProtocol, error: Error)
    func finishedEmptyRequest()

}
class MoviesListViewModel {
    let service = MoviesService()
    var movieList: [Movie] = []
    var pageList: [MoviePage] = []
    var firstPageIndex = 0
    var lastPageIndex = 0
    var lastLoadedPageIndex = 0
    var lastAvailablePageIndex: Int = Int.max
    var searchString: String = ""
    
    weak var delegate: MoviesListViewModelDelegate?
    init() {}
    
    
}
extension MoviesListViewModel: MoviesListViewModelProtocol {
    
    func getMoviesList(_ text: String) {
        searchString = text
        service.getMoviesList(1, searchString: searchString, success: { [weak self] (page) in
            guard let self = self else {
                return
            }
            self.pageList.append(page)
            self.movieList = page.results
            self.firstPageIndex = 1
            self.lastPageIndex = 1
            self.lastAvailablePageIndex = page.totalPages
            self.delegate?.viewModelListChanged(self)
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.delegate?.viewModelReceivedError(self, error: error)
        }
    }
    
    func getNextPage() {
        
        service.getMoviesList(lastPageIndex + 1, searchString: searchString, success: { [weak self] (page) in
            guard let self = self else {
                return
            }
            self.pageLoaded(page)

        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            print(error)
            self.delegate?.viewModelReceivedError(self, error: error)
        }
    }
    func getPreviousPage() {
        guard firstPageIndex <= 1 else {
            delegate?.finishedEmptyRequest()
            return
        }
        service.getMoviesList(firstPageIndex - 1, searchString: searchString, success: { [weak self] (page) in
            guard let self = self else {
                return
            }
            self.pageLoaded(page)
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.delegate?.viewModelReceivedError(self, error: error)
        }
    }
    
    private func pageLoaded(_ page: MoviePage) {
        self.pageList.append(page)
        self.movieList.append(contentsOf: page.results)
        self.lastPageIndex = page.page
        self.delegate?.viewModelListChanged(self)
    }
    
    func didReceiveMemoryWarning() {
        
        movieList.removeAll()
        let filteredList = pageList.filter {
            $0.page == lastLoadedPageIndex
        }
        movieList = filteredList.first?.results ?? []
        firstPageIndex = lastLoadedPageIndex
        lastPageIndex = lastLoadedPageIndex
        self.delegate?.viewModelListChanged(self)
    }
    
    func numberOfRows() -> Int {
        return movieList.count
    }
    
    func movieForIndex(_ index: Int) -> Movie? {
        lastLoadedPageIndex = 1 + (index+(20*firstPageIndex - 1))/20

        return movieList[index]
    }
    func hasNext() -> Bool {
        return lastPageIndex + 1 <= lastAvailablePageIndex
    }
}
