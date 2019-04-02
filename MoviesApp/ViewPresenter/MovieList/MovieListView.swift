
import UIKit

protocol MovieListView: NSObjectProtocol {
    func finishLoading(movies: [Movie])
}

class MovieListViewController: UITableViewController {
    
    private let presenter = MovieListPresenter()
    
    var tableData: [Movie]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(view: self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.loadGenreAndMovies()
        
        // TODO: add loading view
        // TODO: error handler and alerts / retry
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
        if let index = self.tableView.indexPathForSelectedRow?.row,
            let movie = self.tableData?[index]
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
        return self.tableData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListCell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        
        if let movie = tableData?[indexPath.row] {
            cell.titleLabel.text = movie.title
            cell.dateLabel.text = movie.localizedReleaseDate
            cell.genreLabel.text = movie.genresString
            
            cell.coverImageView.image = nil
            if let imageURL = MovieService.smallCoverUrl(movie: movie) {
                cell.coverImageView.load(url: imageURL)
            }
        }
        
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MovieListViewController: MovieListView {
    
    func finishLoading(movies: [Movie]) {
        self.tableData = movies
        self.tableView.reloadData()
        // TODO: add callback for error!!!
    }
    
    
}

