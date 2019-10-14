//
//  DetailViewController.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: BaseViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var favoriteButton: FavoriteButton!
    @IBOutlet weak var heightImageConstraint: NSLayoutConstraint!
    
    var favourite: Favourite?
    
    var movie: Movie?
    
    init(_ movie: Movie) {
        
        super.init(nibName: "DetailViewController", bundle: nil)
        self.movie = movie
        DispatchQueue.global().async {
            self.favourite = SessionManager.shared.getFavourite(movie)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setup()
        
    }
    
    func setup() {
        if let meta = SessionManager.shared.imageConfig?.images {
            let base = meta.baseURL
            if let size = meta.posterSizes.last,
                let posterPath = movie?.posterPath,
                let url = URL(string: "\(base)\(size)\(posterPath)") {
                self.posterImageView.af_setImage(withURL: url, completion: { [weak self] (response) in
                    guard let self = self else {
                        return
                    }
                    switch response.result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            self.heightImageConstraint.constant = self.posterImageView.frame.width * (value.size.height/value.size.width)
                            self.view.layoutIfNeeded()
                        }
                        
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.posterImageView.backgroundColor = .red
                        }
                    }
                })
            }
        }
        self.nameLabel.text = movie?.originalTitle ?? ""
        self.overViewLabel.text = (movie?.overview ?? "")
        self.scoreLabel.text = "Score: \(movie?.voteAverage ?? 0)"
        var genreString = ""
        
        for genreId in movie?.genreIds ?? [] {
            let result = SessionManager.shared.genreList?.genres.filter({
                $0.genreId == genreId
            })
            if let first = result?.first {
                genreString.append("\(first.name), ")
            }
        }
        
        if genreString != "" {
            genreString.removeLast(2)
        }
        
        self.genreLabel.text = genreString
        
        favoriteButton.isSelected = favourite != nil

    }
    
    @IBAction func favorited(_ sender: Any) {
        guard let movie = self.movie else {
            showError("Erro desconhecido")
            return
        }
        if self.favourite != nil {
            SessionManager.shared.deleteMovie(movie)
            self.favourite = nil
        }else {
            self.favourite = SessionManager.shared.saveMovie(movie)
        }
        
        favoriteButton.isSelected = favourite != nil

    }
    
    
}
