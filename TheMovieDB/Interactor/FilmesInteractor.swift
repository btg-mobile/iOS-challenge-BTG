//
//  FilmesInteractor.swift
//  TheMovieDB
//
//  Created by Eric Soares Filho on 15/04/19.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import Foundation

protocol FilmesBusinessLogic
{
    func fetchItems(request: FilmesModel.Fetch.Request)
    func fetchItemsSearch(request: FilmesModel.Fetch.Request)
}

protocol FilmesDataStore
{
    //var name: String { get set }
}

class FilmesInteractor: FilmesBusinessLogic, FilmesDataStore
{
    var presenter: FilmesPresentationLogic?
    var worker: FilmesWorker?
    
    func fetchItems(request: FilmesModel.Fetch.Request) {
      
        worker = FilmesWorker()
        worker?.fetchAll( success: { (object) in
                                    self.presenter?.presentFetchResults(response: object)
                                })
        {(error) in
            self.presenter?.presentFetchResultsError(response: error)
        }
    }
    
    func fetchItemsSearch(request: FilmesModel.Fetch.Request) {
        if request.movieNameSearch == nil || request.movieNameSearch == "" {
            return (self.presenter?.presentFetchResultsError(response: "barra de busca sem valores"))!
        }
        
        worker = FilmesWorker()
        worker?.fetchSearch( search:request.movieNameSearch!, success: { (object) in
            self.presenter?.presentFetchResults(response: object)
        })
        {(error) in
            self.presenter?.presentFetchResultsError(response: error)
        }
    }
}
