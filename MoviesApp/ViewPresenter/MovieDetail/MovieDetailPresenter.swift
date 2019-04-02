
import Foundation

class MovieDetailPresenter {
    
    weak private var view: MovieDetailView?
    
    var movie: Movie!
    
    func setView(view: MovieDetailView) {
        self.view = view
    }
    
    func showMovie() {
        self.view?.updateView(title: movie.title, date: movie.release_date, genre: movie.genresString, overview: movie.overview)
        
        if let imageURL = MovieService.bigCoverUrl(movie: movie) {
            self.view?.loadImage(url: imageURL)
        }
    }
    
}
