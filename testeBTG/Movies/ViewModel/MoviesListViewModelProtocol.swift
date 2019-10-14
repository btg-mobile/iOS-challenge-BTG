//
//  MoviesListViewModelProtocol.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

protocol MoviesListViewModelProtocol {
    func getMoviesList(_ text: String)
    func getNextPage()
    func getPreviousPage()
    func numberOfRows() -> Int
    func movieForIndex(_ index: Int) -> Movie?
    func didReceiveMemoryWarning()
    func hasNext() -> Bool
}
extension MoviesListViewModelProtocol {
    func getNextPage() {}
    func getPreviousPage() {}
    func numberOfRows() -> Int {
        return 0
    }
    func hasNext() -> Bool {
        return false
    }
}
