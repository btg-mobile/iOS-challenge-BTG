//
//  FilmesPresenter.swift
//  TheMovieDB
//
//  Created by Eric Soares Filho on 15/04/19.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit

protocol FilmesPresentationLogic
{
    func presentFetchResults(response: [FilmesModel.Fetch.Response])
    func presentFetchResultsError(response: String)
}

class FilmesPresenter: FilmesPresentationLogic
{
    //FilmesViewController->FilmesDisplayLogic
    weak var viewController: FilmesDisplayLogic?
    
    // MARK: - Presentation logic
    func presentFetchResults(response: [FilmesModel.Fetch.Response]) {
        viewController?.successFetchedItems(viewModel: prepareResultToViewModel(result: response))
    }
    
    func presentFetchResultsError(response: String) {
        print(response)
    }
    
    private func prepareResultToViewModel(result: [FilmesModel.Fetch.Response]) -> [FilmesModel.Fetch.ViewModel]{
        var responseEnd = [FilmesModel.Fetch.ViewModel]()
        
        for responseAux in result {
            var tempViewModel = FilmesModel.Fetch.ViewModel()
            tempViewModel.id = responseAux.id
            tempViewModel.ano = responseAux.ano
            tempViewModel.avaliacao = responseAux.avaliacao
            tempViewModel.generos = responseAux.generos
            tempViewModel.nome = responseAux.nome
            tempViewModel.poster = responseAux.poster
            tempViewModel.sinopse = responseAux.sinopse
            
            responseEnd.append(tempViewModel)
        }
        return responseEnd
    }
}
