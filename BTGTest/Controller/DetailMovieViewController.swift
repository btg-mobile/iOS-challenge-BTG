//
//  DetailMovie.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 13/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favotiteBtn: FavoriteView!
    
    var model: MovieDetailModelDelegate!
    var business: MovieListManeger!
    
    var movies: [Movie] = []
    var images: [String: Data]? = [:]
    var genres: [Genre]?
    var passedMovie: Movie?
    var selectedMovie: Movie?
    
    var cellHeight: CGFloat = 0
    var cellWidth: CGFloat = 0
    var betweenCellDistance: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        setup()
        favoriteConfig()
    }
    
    func setup() {
        cellHeight = 220/898 * UIScreen.main.bounds.height
        cellWidth = 130/414 * UIScreen.main.bounds.width
        betweenCellDistance = 12/414 * UIScreen.main.bounds.width

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MovieDetailCellView", bundle: nil), forCellReuseIdentifier: "detailMoveCell")
        self.tableView.register(UINib(nibName: "MovieRecomendCellView", bundle: nil), forCellReuseIdentifier: "movieRecomendCell")
        
        configuration()
        model.getImage(path: "w500" + (passedMovie?.backdropPath ?? ""), movie: passedMovie!)
        model.getSimilar([APIQuery.key.rawValue: APIRequest.key.rawValue], pathParams: passedMovie?.id)
        model.getGenres([APIQuery.key.rawValue: APIRequest.key.rawValue])
    }
    
    static func instantiateFromXib() -> DetailMovieViewController{
        let vc = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
        vc.modalPresentationStyle = .currentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
    
    func favoriteConfig() {
        passedMovie?.isFavorited = UserDefaults.standard.bool(forKey: "\(passedMovie?.id ?? 0)")
        if passedMovie!.isFavorited{
            favotiteBtn.image = UIImage(systemName: "heart.fill")
        }
        else {
            favotiteBtn.image = UIImage(systemName: "heart")
        }
    }
    
    func movieGenre() -> String{
        let mvGenres = genres?.filter {(passedMovie?.genreIds?.contains($0.id ?? 0) ?? false)}
        var text = ""
        for genre in mvGenres ?? [Genre()] {
            text += (genre.name ?? "") + " "
        }
        return text
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func favorite(_ sender: Any) {
        let url = "?\(APIQuery.key.rawValue)=\(APIRequest.key.rawValue)&\(APIQuery.sessionID.rawValue)=\(APIRequest.sessionID.rawValue)"
        var param: [String: Any] = [:]
        param["media_type"] = "movie"
        param["media_id"] = passedMovie?.id
        param["favorite"] = !(passedMovie?.isFavorited ?? false)
        model.markFavorite(parameters: param, url: url, headers: ["Content-Type":"application/json;charset=utf-8"])
    }
    
    
    @objc func selectView(_ sender: UITapGestureRecognizer? , index: Int) {
        selectedMovie = movies[sender?.view?.tag ?? 0]
        let vc = DetailMovieViewController.self.instantiateFromXib()
        vc.passedMovie = selectedMovie
        present(vc, animated: true)
    }
}

extension DetailMovieViewController{
    func configuration(){
        model = MovieDetailModel()
        model.detailDelegate = self
        business = MovieListManeger()
        business.delegate = model.detailDelegate
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            let heigth = ((CGFloat(movies.count)/3) * cellHeight) + ((CGFloat(movies.count)) * betweenCellDistance )
            print(heigth)
            return heigth
        }
        return 440
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
         let cell = self.tableView.dequeueReusableCell(withIdentifier: "detailMoveCell") as! MovieDetailCell
            cell.backDrop.image = UIImage(data: passedMovie?.dataBackdrop ?? Data())
            cell.titulo.text = passedMovie?.title ?? "batata"
            cell.descricao.text = passedMovie?.overview ?? ""
            cell.elenco.text = "Vote Avarege: " + "\(passedMovie?.voteAverage ?? 0) " + movieGenre()
            return cell
        }
            
        else{
            let cell = UITableViewCell()
            cell.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
            if !movies.isEmpty{
                model.createView().forEach({cell.addSubview($0)})
            }
            return cell
        }
    }
}

extension DetailMovieViewController: MovieListViewDelegate{
    func obtainData(movies: [Movie]) {
        self.movies = movies
        for movie in movies{
            model.getImage(path: "w500" + (movie.posterPath ?? ""), movie: movie)
        }
        tableView.reloadData()
    }
    
    func populate(WithImage image: Data, movie: Movie) {
        movie.dataBackdrop = image
        images?["\(String(describing: movie.id))"] = image
        tableView.reloadData()
    }
    
    func markFavorite() {
        passedMovie?.isFavorited = !passedMovie!.isFavorited
        UserDefaults.standard.set(passedMovie?.isFavorited, forKey: "\(passedMovie!.id ?? 0)")
        favoriteConfig()
    }
    
    func obtainGenres(genres: [Genre]) {
        self.genres = genres
        tableView.reloadData()
    }
}

