//
//  ViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataProvider : MovieDataProvider = MovieDataProvider()
    var moviesArray : [Movie]?
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //CV DELEGATE AND DATASOURCE
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
        self.dataProvider.getPopularMovies { result in
            
            switch result {
            case .failure (let error):
                print(error)
            case .success(let movies):
                
                self.moviesArray = movies
                
                print("\(self.moviesArray?.count ?? 0) registros obtidos da API")
                
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
                
            }
            
        }
        
        //REGISTER CELL
        self.movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesArray?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.setupCell(movie: (self.moviesArray?[indexPath.row])!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.moviesArray?[indexPath.row].id ?? "")
        print("https://image.tmdb.org/t/p/w500/\(self.moviesArray?[indexPath.row].backdropPath)")
        print("===")
        print(self.moviesArray?[indexPath.row].title ?? "")
        print(self.moviesArray?[indexPath.row].overview ?? "")
        
    }
    
}
