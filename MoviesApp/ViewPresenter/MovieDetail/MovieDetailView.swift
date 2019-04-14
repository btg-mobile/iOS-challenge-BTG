
import UIKit
import Disk

protocol MovieDetailView: NSObjectProtocol {
    func setMovie(movie: Movie)
    func updateView(title: String, date: String, genre: String, overview: String)
    func loadImage(url: URL)
}

class MovieDetailViewController: UIViewController {
    
    private let presenter = MovieDetailPresenter()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(view: self)
        self.presenter.showMovie()
        
        if !Disk.exists("favorite.json", in: .applicationSupport) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addTapped))
        } else {
            do {
                let retrievedFavorites = try Disk.retrieve("favorite.json", from: .applicationSupport, as: [Movie].self)
                let found = retrievedFavorites.filter {
                    $0.title == self.presenter.movie.title
                }
                if found.isEmpty {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addTapped))
                } else {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(addTapped))
                }
            } catch {
                print(error.localizedDescription)
            }
        }

        
        // TODO: add scrolls
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func addTapped() {
        
        //if the file exists append
        if Disk.exists("favorite.json", in: .applicationSupport) {
            
            //if the movie exists has to be deleted else has to be saved
            do {
                var retrievedFavorites = try Disk.retrieve("favorite.json", from: .applicationSupport, as: [Movie].self)
                let index = retrievedFavorites.index{ $0.title == self.presenter.movie.title}
                if let index = index {
                    retrievedFavorites.remove(at: index)
                    try Disk.save(retrievedFavorites, to: .applicationSupport, as: "favorite.json")
                }
                else {
                    try Disk.append([self.presenter.movie], to: "favorite.json", in: .applicationSupport)
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            try? Disk.save([self.presenter.movie], to: .applicationSupport, as: "favorite.json")
        }

        _ = navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieDetailViewController: MovieDetailView {
    
    func setMovie(movie: Movie) {
        self.presenter.movie = movie
    }
    
    func updateView(title: String, date: String, genre: String, overview: String) {
        self.title = title
        self.titleLabel.text = title
        self.dateLabel.text = date.formattedDateFromString(dateString: date, withFormat: "dd/MM/yyyy")
        self.genreLabel.text = genre
        self.overviewLabel.text = overview
    }
    
    func loadImage(url: URL) {
        self.coverImageView.load(url: url)
    }
    
}
