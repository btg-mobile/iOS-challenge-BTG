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

        self.controller = MovieController()
        // Do any additional setup after loading the view.
        favoritesSearchBar.searchTextField.backgroundColor = .white
        self.addRefreshingControl()
        
        //CV DELEGATE AND DATASOURCE
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        
        //REGISTER CELL
        self.favoritesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        controller?.loadFavoriteMovies()
        print("passei")
        self.favoritesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetails" {
            
            if let vc: DetailsViewController = segue.destination as? DetailsViewController {
                
                if let indexPath = favoritesTableView.indexPathForSelectedRow {
                    vc.movie = self.controller?.loadMovieWithIndexPath(indexPath: indexPath)
                }
                
            }
            
        }
        
    }
    
    func addRefreshingControl(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .green
        self.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.favoritesTableView.addSubview(refreshControl!)
        
        
    }
    
    @objc func refreshList() {
        
        self.refreshControl?.endRefreshing()
        self.controller?.loadMovies()
        self.favoritesTableView.reloadData()
        
    }
    
}

extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.controller?.numberOfRowsForFavorites() ?? 0
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
//        cell.setupCell(movie: (self.controller?.loadMovieWithIndexPathForFavorites(indexPath: indexPath))!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToDetails", sender: self)
        
    }
    
    
}

//MARK: - UISearchBar Delegate methods

extension FavoritesViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                //self.controller?.updateArray()
                self.favoritesTableView.reloadData()
            }
            
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                //self.controller?.updateArray()
                self.favoritesTableView.reloadData()
            }
            
        }
        else {
            
            //self.controller?.searchByValue(searchText: searchText)
            
            self.favoritesTableView.reloadData()
        }
        
    }
    
}
