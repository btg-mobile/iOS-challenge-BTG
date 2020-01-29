//
//  ViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var controller : MovieController?
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieSearchBar.searchTextField.backgroundColor = .white
        
        //Delegate and protocols
        self.controller = MovieController()
        self.controller?.delegate = self
        self.controller?.loadMovies()
        
        //CV DELEGATE AND DATASOURCE
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
        //REGISTER CELL
        self.movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetails" {
            
            if let vc: DetailsViewController = segue.destination as? DetailsViewController {
                
                if let indexPath = movieTableView.indexPathForSelectedRow {
                    vc.movie = self.controller?.loadMovieWithIndexPath(indexPath: indexPath)
                }
                
            }
            
        }
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.setupCell(movie: (self.controller?.loadMovieWithIndexPath(indexPath: indexPath))!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToDetails", sender: self)
        
    }
    
}

//MARK: - UISearchBar Delegate methods

extension ViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text?.count == 0 {

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.controller?.updateArray()
                self.movieTableView.reloadData()
            }
            
        }

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.controller?.updateArray()
                self.movieTableView.reloadData()
            }
            
        }
        else {
            
            self.controller?.searchByValue(searchText: searchText)
            
            self.movieTableView.reloadData()
        }
        
    }
    
}

extension ViewController : MovieControllerDelegate {
    
    func successOnLoading() {
        
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
        
    }
    
    func errorOnLoading(error: Error?) {
        
        if !error!.localizedDescription.isEmpty {
        print("Problema ao carregar os dados de Filmes")
        
            let alerta = UIAlertController(title: "Erro", message: "Problema ao carregar os dados de Filmes", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        
            alerta.addAction(btnOk)
            
            self.present(alerta, animated: true)
        }
    }
    
}

