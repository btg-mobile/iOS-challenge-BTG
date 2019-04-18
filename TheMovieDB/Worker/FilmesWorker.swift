//
//  FilmesWorker.swift
//  TheMovieDB
//
//  Created by Eric Soares Filho on 15/04/19.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit
typealias FilmesResponseHandler = (_ response: [FilmesModel.Fetch.Response]) ->()
typealias FilmesResponseHandlerError = (_ response: String) ->()

class FilmesWorker{
    
    enum APPError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }
    
    enum Result<Filmes> {
        case success([FilmesModel.Fetch.Response])
        case failure(APPError)
    }
    
    func fetchAll(success:@escaping(FilmesResponseHandler),
               fail:@escaping(FilmesResponseHandlerError))
    {
        self.dataRequest(){ (result: Result) in
            switch result {
            case .success(let object):
                success(object)
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
    func fetchSearch(   search: String,
                        success:@escaping(FilmesResponseHandler),
                        fail:@escaping(FilmesResponseHandlerError))
    {
        self.dataRequestFindByMovie(search: search){ (result: Result) in
            switch result {
            case .success(let object):
                success(object)
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
    
    func dataRequest(completion: @escaping (Result<[FilmesModel.Fetch.Response]>) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=a922a50d4aa15d25e6b351cdc67dee6d&language=pt-BR&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as AnyObject
                let filmes = self.convertToMovies(json: jsonResponse )
                completion(Result.success(filmes!))
            } catch let error {
                completion(Result.failure(APPError.jsonParsingError(error as! DecodingError)))
            }
        }
        task.resume()
    }
    
    func dataRequestFindByMovie(search: String, completion: @escaping (Result<[FilmesModel.Fetch.Response]>) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=a922a50d4aa15d25e6b351cdc67dee6d&language=pt-BR&query=\(search)&page=1&include_adult=false") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as AnyObject
                let filmes = self.convertToMovies(json: jsonResponse )
                completion(Result.success(filmes!))
            } catch let error {
                completion(Result.failure(APPError.jsonParsingError(error as! DecodingError)))
            }
        }
        task.resume()
    }
    
    
    
    
    
    func convertToMovies(json: AnyObject) -> [FilmesModel.Fetch.Response]? {
        var moviesToReturn = [FilmesModel.Fetch.Response]()
        print(json)
        if let results = json["results"] as? [AnyObject] {
            print(results)
            for jsonAux in results {
                var filmeAux = FilmesModel.Fetch.Response()
                
                if let id = jsonAux["id"] as? Int {
                    filmeAux.id = id
                }
                
                if let titulo = jsonAux["title"] as? String {
                    filmeAux.nome = titulo
                }
                
                if let poster = jsonAux["poster_path"] as? String {
                    filmeAux.poster = poster
                }
                
                if let ano = jsonAux["release_date"] as? String {
                    filmeAux.ano = ano
                }
                
                if let sinopse = jsonAux["overview"] as? String {
                    filmeAux.sinopse = sinopse
                }
                
                if let avaliacao = jsonAux["vote_average"] as? Double? {
                    filmeAux.avaliacao = avaliacao
                }
                
                //TODO: Generos
                
                moviesToReturn.append(filmeAux)
            }
        }
        
        return moviesToReturn
    }
    
    
}
