//
//  BTGMoviesTests.swift
//  BTGMoviesTests
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import XCTest
@testable import BTGMovies

class BTGMoviesTests: XCTestCase {

    var movie: Movie!
    var viewModel: MovieViewModel!
    var sut: MovieDetailViewController!

    override func setUp() {
        super.setUp()
        movie = Movie(id: 10, title: "Titulo", overview: "Sinopse", releaseDate: Date(), posterPath: "", backdropPath: "", voteAverage: 5.5)
        viewModel = MovieViewModel(movie)
        sut = MovieDetailViewController(viewModel: viewModel)
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
        viewModel.removeMovie()
    }

    func testViewModel() {
        XCTAssertEqual(viewModel.title, "Titulo")
        XCTAssertNotEqual(viewModel.overview, "")
    }

    func testCoreData() {
        viewModel.removeMovie()
        XCTAssertEqual(viewModel.isFavorite, false)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.image, #imageLiteral(resourceName: "favorites-tab-icon").withRenderingMode(.alwaysOriginal))
        viewModel.saveMovie()
        XCTAssertEqual(viewModel.isFavorite, true)
    }
    
    func testDetailViewController() {
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.releaseYearLabel.text, viewModel.releaseDate)
        XCTAssertEqual(sut.overviewLabel.text, viewModel.overview)
        XCTAssertEqual(sut.ratingLabel.text, viewModel.voteAverage)
    }
}
