
import UIKit

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
        
        // TODO: add scrolls
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        self.dateLabel.text = date
        self.genreLabel.text = genre
        self.overviewLabel.text = overview
    }
    
    func loadImage(url: URL) {
        self.coverImageView.load(url: url)
    }
    
}
