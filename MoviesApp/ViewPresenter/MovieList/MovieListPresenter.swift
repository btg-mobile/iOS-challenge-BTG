
import Foundation

class MovieListPresenter {
    
    weak private var view: MovieListView?
    
    var isLoading = false
    var currentPage = 0
    var movies: [Movie]?
    var lastMovieList: MovieList?
    
    
    func setView(view: MovieListView) {
        self.view = view
    }
    
    func loadGenreAndMovies() {
        if !GenreList.hasList() {
            self.loadGenre()
        }else{
            if self.lastMovieList == nil {
                self.loadDataFromPage(page: 1)
            }
        }
    }
    
    func loadGenre() {
        MovieService.genre { (genreList) in
            print("Genre List Loaded ", genreList?.genres.count as Any)
            if genreList != nil {
                GenreList.setGenreList(genre: genreList!)
            }
            self.loadDataFromPage(page: 1)
            // TODO: add callback for error!!!
        }
    }
    
    func loadDataFromPage(page: Int) {
        if self.isLoading { return }
        self.isLoading = true
        
        print("loadDataFromPage ", page)
//        MovieService.upcoming(page: page) { movieList in
//            debugPrint("Movies Page Loaded ", page)
//            
//            if movieList != nil {
//                self.setMovieList(newList: movieList!)
//                self.currentPage = page
//            }
//            
//            self.isLoading = false
//            // TODO: add callback for error!!!
//        }
        
        MovieService.popular(page: page) { movieList in
            debugPrint("Movies Page Loaded ", page)
            
            if movieList != nil {
                self.setMovieList(newList: movieList!)
                self.currentPage = page
            }
            
            self.isLoading = false
            // TODO: add callback for error!!!
        }

    }
    
    func loadNextPage() {
        self.loadDataFromPage(page: self.currentPage + 1)
    }
    
    func setMovieList(newList: MovieList) {
        self.lastMovieList = newList
        if self.movies == nil {
            self.movies = newList.results
        }else{
            self.movies!.append(contentsOf: newList.results)
        }
        self.view?.finishLoading(movies: self.movies!)
    }
    
    func canLoadMore(indexPath: IndexPath) -> Bool {
        if let movies = self.movies {
            let lastRow = movies.count - 1
            if indexPath.row == lastRow && self.lastMovieList!.page < self.lastMovieList!.total_pages {
                return true
            }
        }
        return false
    }
    
}
