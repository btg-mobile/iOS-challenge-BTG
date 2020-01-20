//
//  MovieFavoriteViewController.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 19/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import UIKit

class MovieFavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var model: MovieFavoriteModelDelegate!
    var business: MovieListManeger!
    var movies: [Movie?] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setUp()
        let pth = [APIQuery.key.rawValue: APIRequest.key.rawValue, APIQuery.sessionID.rawValue: APIRequest.sessionID.rawValue]
        model.getFavorite(pth)
    }
    
    private func setUp(){
        tableView.register(UINib(nibName: "MoviePosterCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.addSubview(refreshControl)
    }

    static func instantiateFromXib() -> MovieFavoriteViewController{
        let vc = MovieFavoriteViewController(nibName: "MovieFavoriteViewController", bundle: nil)
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

extension MovieFavoriteViewController{
    func configuration(){
        model = MovieFavoriteModel()
        model.movieListeDelegate = self
        business = MovieListManeger()
        business.delegate = model.movieListeDelegate
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        let pth = [APIQuery.key.rawValue: APIRequest.key.rawValue, APIQuery.sessionID.rawValue: APIRequest.sessionID.rawValue]
        model.getFavorite(pth)
        refreshControl.endRefreshing()
    }
}

extension MovieFavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MoviePosterCell else{print("error"); return UITableViewCell()}

        cell.titulo.text = movies[indexPath.row]?.title ?? ""
        cell.poster.image = UIImage(data: movies[indexPath.row]?.data ?? Data())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if movies.count != 0{
            guard let movie = movies[indexPath.row] else{print("Filme inexistente"); return}
            self.movieSelected(movie: movie)
        }
    }
    
}

extension MovieFavoriteViewController: MovieListViewDelegate{
    func obtainData(movies: [Movie]) {
        self.movies = movies
        //print("🤯🤯",self.movies)
        tableView.reloadData()
        for movie in movies{
            model.getImage(path: "w500" + (movie.posterPath ?? ""), movie: movie)
        }
    }
    
    func populate(WithImage image: Data, movie: Movie){
        movie.data = image
        tableView.reloadData()
    }
    
}
