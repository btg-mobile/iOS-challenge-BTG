//
//  MovieDataProvider.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

protocol MovieDataProviderDelegate : class {
    
    func successOnLoading(_ movies: [Movie]?, movieSelection: Constants.MovieSelection)
    func errorOnLoading(error: Error?)
    func getTotalPages(_ totalOfPages: Int)

}

class MovieDataProvider {
    
    weak var delegate : MovieDataProviderDelegate?
    var page: Int?
    var language: Constants.language
    var category: Constants.category
    var movieSelection: Constants.MovieSelection
    var resourceString: URL?

    init(page: Int?, language: Constants.language = .portuguese, category: Constants.category, movieSelection: Constants.MovieSelection){
        self.page = page
        self.language = language
        self.category = category
        self.movieSelection = movieSelection
        self.resourceString = URL(string: "\(Constants.API.baseURL)\(category)/\(movieSelection.rawValue)?api_key=\(Constants.API.privateKey)&language=\(language)&page=\(page ?? 1)")
    }

    //MARK: - Movie request
    func getMovies() {
        
        guard let resourceURL = resourceString else {fatalError("Problema ao obter os dados")}
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, res, err) in
            
            guard let jsonData = data else {
                self.delegate?.errorOnLoading(error: err)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieHeader = try decoder.decode(MovieHeader.self, from: jsonData)
                if let movieResults = movieHeader.results {
                    self.delegate?.successOnLoading(movieResults, movieSelection: self.movieSelection)
                    
                    if self.page == 1 {
                        self.delegate?.getTotalPages(movieHeader.totalPages ?? 0)
                    }
                
                    print("API LOG####################")
                    print("Pagination #\(self.page ?? 0)")
                    print("\(self.resourceString!)")
                    
                }
            }catch{
                self.delegate?.errorOnLoading(error: error)
            }
            
        }
        
        dataTask.resume()
        
    }
    
    //MARK: - Genre id request
    
    func getGenreIds(completion: @escaping(Genre) -> Void) {
        
        let resourceURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=132dfc8e68a337152fd3e36d63c77677&language=pt-BR"
    
        guard let url = URL(string: resourceURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let jsonData = data else {
                return
            }
            
            do {
                
                let genres = try JSONDecoder().decode(Genre.self, from: jsonData)
                
                completion(genres)
                
            }catch{
                print("Erro ao obter Generos")
            }
            
        }.resume()
        
    }
    
}
