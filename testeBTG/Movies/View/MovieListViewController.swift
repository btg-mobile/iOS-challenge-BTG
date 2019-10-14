//
//  MovieListViewController.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

class MovieListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel: MoviesListViewModelProtocol
    
    init(_ viewModel: MoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "MovieListViewController", bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        let tempViewModel = MoviesListViewModel()

        viewModel = tempViewModel

        super.init(coder: aDecoder)
        tempViewModel.delegate = self

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMoviesList("")

    }
    func setup() {
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        showSpinner()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewModel.didReceiveMemoryWarning()
    }

}
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell,
            let movie = viewModel.movieForIndex(indexPath.row) else {
                return UITableViewCell()
        }
        
        cell.configureForMovie(movie)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRows() - 1 {
            if viewModel.hasNext() {
//                tableView.setContentOffset(tableView.contentOffset, animated: false)
                showSpinner()
                
                viewModel.getNextPage()
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel.movieForIndex(indexPath.row) else {
            return
        }
        let view = DetailViewController(movie)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
extension MovieListViewController: MoviesListViewModelDelegate {
    func viewModelListChanged(_ viewModel: MoviesListViewModelProtocol) {

        hideSpinner()
        tableView?.reloadData()
    }
    
    func viewModelReceivedError(_ viewModel: MoviesListViewModelProtocol, error: Error) {

        hideSpinner()
        showError(error.localizedDescription)
    }
    
    func finishedEmptyRequest() {
        hideSpinner()

    }
}
extension MovieListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSpinner()
        viewModel.getMoviesList(searchBar.text ?? "")
        searchBar.resignFirstResponder()

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
        
}
