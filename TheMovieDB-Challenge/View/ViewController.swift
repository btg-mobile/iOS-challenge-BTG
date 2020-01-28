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
    var moviesArray : [MovieResults]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.dataProvider.getString()
        
        self.dataProvider.getPopularMovies { result in
            
            switch result {
            case .failure (let error):
                print(error)
            case .success(let movies):
                self.moviesArray = movies
                print("\(String(describing: self.moviesArray?.count)) registros obtidos da API")
                print(movies[0].overview)
                print("======")
                print(self.moviesArray?[0].overview)
            }
            
        }
    }


}

