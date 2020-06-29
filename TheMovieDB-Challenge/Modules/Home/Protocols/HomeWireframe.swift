//
//  HomeWireframe.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 24/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

import UIKit

protocol HomeViewToPresenterProtocol: class {
    var view: HomePresenterToViewProtocol? { get set }
    var interactor: HomePresenterToInteractorProtocol? { get set }
    var router: HomePresenterToRouterProtocol? { get set }
    func getMovies(page: Int, category: Constants.category, movieSelection: Constants.MovieSelection)
    func numberOfSections() -> Int
    func getNumberOfRowsInSection() -> Int
    func loadMovieWithIndexPath(indexPath: IndexPath, movieSelection: Constants.MovieSelection, favorite: Bool) -> Movie
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    func getMovies(page: Int, category: Constants.category, movieSelection: Constants.MovieSelection)
}

protocol HomeInteractorToPresenterProtocol: class {
    func returnMovieResults(movies: [Movie])
    func problemOnFetchingData(error: Constants.errorTypes)
}

protocol HomePresenterToViewProtocol: class {
    func showMovieResults()
    func problemOnFetchingData(error: Constants.errorTypes)
}

protocol HomePresenterToRouterProtocol: class {
    static var mainstoryboard: UIStoryboard { get }
    static func createModule(as presentationStyle: UIModalPresentationStyle) -> UIViewController
}
