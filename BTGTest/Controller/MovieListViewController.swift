//
//  MovieListViewController.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 12/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var model: MovieListModelDelegate!
    var business: MovieListManeger!
    var movies: [Movie?] = []
    var filteredMovies: [Movie?] = []
    var page: Int = 2
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setUp()
        searchSetup()
        let pth = [APIQuery.key.rawValue: APIRequest.key.rawValue, APIQuery.language.rawValue: APILenguages.portuguese.rawValue]
        model.getPopular(pth)
    }
    
    private func setUp(){
        tableView.register(UINib(nibName: "MoviePosterCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func searchSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navBar.topItem?.searchController = searchController
        definesPresentationContext = true
    }
    
    static func instantiateFromXib() -> MovieListViewController{
        let vc = MovieListViewController(nibName: "MovieListViewController", bundle: nil)
        vc.modalPresentationStyle = .currentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
    private func movieSelected(movie: Movie){
        let vc = DetailMovieViewController.instantiateFromXib()
        vc.passedMovie = movie
        present(vc, animated: true)
    }
}

extension MovieListViewController{
    func configuration(){
        model = MovieListModel()
        model.movieListeDelegate = self
        business = MovieListManeger() 
        business.delegate = model.movieListeDelegate
        
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies.count
        }
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row, movies.count)
        if movies.count == indexPath.row + 1 && page < 100 {
            let pth: [String:Any] = [APIQuery.key.rawValue: APIRequest.key.rawValue, APIQuery.language.rawValue: APILenguages.portuguese.rawValue, APIQuery.page.rawValue: page]
            page += 1
            print("hehehe")
            model.getPopular(pth)
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MoviePosterCell else{print("error"); return UITableViewCell()}
        
        let movie: Movie
        if isFiltering{
            movie = filteredMovies[indexPath.row] ?? Movie()
        } else {
            movie = movies[indexPath.row] ?? Movie()
        }
        
        cell.titulo.text = "\(movie.title ?? "") \(movie.date ?? "")"
        cell.poster.image = UIImage(data: movie.data ?? Data())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie: Movie?
        if isFiltering{
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        
        if searchController.isActive {
            searchController.isActive = false
        }
        
        guard let mv = movie else{print("Filme inexistente"); return}
        self.movieSelected(movie: mv)
    }
    
}

extension MovieListViewController: MovieListViewDelegate {
    func obtainData(movies: [Movie]) {
        
        if isFiltering {
            self.filteredMovies = movies
            tableView.reloadData()
            for movie in movies{
                model.getImage(path: "w500" + (movie.posterPath ?? ""), movie: movie)
            }
        } else {
            for movie in movies{
                self.movies.append(movie)
                tableView.reloadData()
                model.getImage(path: "w500" + (movie.posterPath ?? ""), movie: movie)
            }
        }
    }
    
    func populate(WithImage image: Data, movie: Movie){
        movie.data = image
        tableView.reloadData()
    }
}

extension MovieListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func search(_ searchText: String) {
        let parameters = [APIQuery.key.rawValue: APIRequest.key.rawValue, APIQuery.query.rawValue: searchText]
        model.getSearch(parameters)
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        search(searchBar.text!)
    }
    
    
}
