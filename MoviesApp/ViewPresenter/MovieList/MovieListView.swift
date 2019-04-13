
import UIKit
import Disk

protocol MovieListView: NSObjectProtocol {
    func finishLoading(movies: [Movie])
}

class MovieListViewController: UITableViewController {
    
    private let presenter = MovieListPresenter()
    
    var tableData: [Movie]?
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [Movie]()
    //var retrievedFavorites: [FavoriteMovie]?
    var retrievedFavorites: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(view: self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        
        //Setup the Search Controller
        searchController.searchResultsUpdater = self
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
        }
        searchController.searchBar.placeholder = "Search Movie"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.tabBarItem.tag == 0 {
            self.presenter.loadGenreAndMovies()
        } else {
            debugPrint("Loading favorite movies")

            do {
                
                retrievedFavorites = try Disk.retrieve("favorite.json", from: .applicationSupport, as: [Movie].self)
                if let retrievedMovies = retrievedFavorites {
                    finishLoading(movies: retrievedMovies)
                }
                dump(retrievedFavorites)
                
                
            } catch {
                print(error.localizedDescription)
            }

        }
        
        
        // TODO: add loading view
        // TODO: error handler and alerts / retry
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText (_ searchText: String, scope: String = "All") {
        if navigationController?.tabBarItem.tag == 0 {
            filteredMovies = (tableData?.filter({ (movie: Movie) -> Bool in
                return movie.title.lowercased().contains(searchText.lowercased())
            }))!
        } else {
            filteredMovies = (retrievedFavorites?.filter({ (movie: Movie) -> Bool in
                return movie.title.lowercased().contains(searchText.lowercased())
            }))!
        }
        
        tableView.reloadData()
        
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "movieDetailSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.presenter.canLoadMore(indexPath: indexPath) {
            self.presenter.loadNextPage()
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if isFiltering() {
            if let index = self.tableView.indexPathForSelectedRow?.row {
                let movie = self.filteredMovies[index]
                if let destination = segue.destination as? MovieDetailView {
                    destination.setMovie(movie: movie)
                }
            }
            return
        }

        if let index = self.tableView.indexPathForSelectedRow?.row,
            let movie = self.tableData?[index] ?? self.retrievedFavorites?[index]
        {
            if let destination = segue.destination as? MovieDetailView {
                destination.setMovie(movie: movie)
            }
        }

        
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }
        
        if navigationController?.tabBarItem.tag == 0 {
            return self.tableData?.count ?? 0
        } else {
            return retrievedFavorites?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListCell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        
        if isFiltering() {
            let movieFiltered = filteredMovies[indexPath.row]
            cell.titleLabel.text = movieFiltered.title
            cell.dateLabel.text = movieFiltered.localizedReleaseDate
            cell.genreLabel.text = movieFiltered.genresString
            
            cell.coverImageView.image = nil
            if let imageURL = MovieService.smallCoverUrl(movie: movieFiltered) {
                cell.coverImageView.load(url: imageURL)
            }
            
        } else {
            if navigationController?.tabBarItem.tag == 0 {
                if let movie = tableData?[indexPath.row] {
                    cell.titleLabel.text = movie.title
                    cell.dateLabel.text = movie.localizedReleaseDate
                    cell.genreLabel.text = movie.genresString
                    
                    cell.coverImageView.image = nil
                    if let imageURL = MovieService.smallCoverUrl(movie: movie) {
                        cell.coverImageView.load(url: imageURL)
                    }
                }
            } else {
                if let movie = retrievedFavorites?[indexPath.row] {
                    cell.titleLabel.text = movie.title
                    cell.dateLabel.text = movie.localizedReleaseDate
                    cell.genreLabel.text = movie.genresString
                    
                    cell.coverImageView.image = nil
                    if let imageURL = MovieService.smallCoverUrl(movie: movie) {
                        cell.coverImageView.load(url: imageURL)
                    }
                }
            }
        }
        
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}

extension MovieListViewController: MovieListView {
    
    func finishLoading(movies: [Movie]) {
        self.tableData = movies
        self.tableView.reloadData()
        // TODO: add callback for error!!!
    }
    
    
}

