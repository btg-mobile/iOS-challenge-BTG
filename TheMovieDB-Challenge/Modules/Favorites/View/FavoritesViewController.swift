//
//  FavoritesViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 30/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var controller : MovieController?
    var refreshControl: UIRefreshControl?
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var favoritesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //favoritesSearchBar.searchTextField.backgroundColor = .white
        self.addRefreshingControl()
        
        self.controller = MovieController()
        controller?.loadFavoriteMovies()
        
        //CV DELEGATE AND DATASOURCE
//        self.favoritesTableView.delegate = self
//        self.favoritesTableView.dataSource = self
        
        //REGISTER CELL
        //self.favoritesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.controller?.delegate = self
        //self.tempGenreArray = self.controller?.getgenresArray() ?? []
        self.controller?.loadFavoriteMovies()
//        self.favoritesTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetailsOfFav" {
            
            if let vc: DetailsViewController = segue.destination as? DetailsViewController {
                
                if let indexPath = favoritesTableView.indexPathForSelectedRow {
                    vc.movie = self.controller?.loadMovieWithIndexPath(indexPath: indexPath, favorite: true)
                }
                
            }
            
        }
        
    }
    
    func addRefreshingControl(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .green
        self.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
//        self.favoritesTableView.addSubview(refreshControl!)
        
        
    }
    
    @objc func refreshList() {
        print("Pull to refresh")
        self.refreshControl?.endRefreshing()
        self.controller?.loadFavoriteMovies()
        self.favoritesTableView.reloadData()
        
    }
    
}

//extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.controller?.numberOfRowsForFavorites() ?? 0
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell : MovieCollectionViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
//
//        cell.setupCell(movie: (self.controller?.loadMovieWithIndexPathForFavorites(indexPath: indexPath))!)
//
//        return cell
//
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if let removeId = self.controller?.loadMovieWithIndexPathForFavorites(indexPath: indexPath).id {
//
//            self.controller?.removeFavoriteMovie(id: removeId)
//
//        }
//
//        self.controller?.loadFavoriteMovies()
//        self.favoritesTableView.reloadData()
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        self.performSegue(withIdentifier: "goToDetailsOfFav", sender: self)
//
//    }
//
//
//}

//MARK: - UISearchBar Delegate methods

extension FavoritesViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.controller?.updateFavoriteArray()
                self.favoritesTableView.reloadData()
            }
            
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.controller?.updateFavoriteArray()
                self.favoritesTableView.reloadData()
            }
            
        }
        else {
            
            self.controller?.searchFavoriteByValue(searchText: searchText)
            
            self.favoritesTableView.reloadData()
        }
        
    }
    
}
