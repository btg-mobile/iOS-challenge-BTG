//
//  FilmesViewController.swift
//  TheMovieDB
//
//  Created by entelgy on 15/04/2019.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit

protocol FilmesDisplayLogic: class
{
    //Criar metodos de resultado da Presenter
    func successFetchedItems(viewModel: [FilmesModel.Fetch.ViewModel])
    func errorFetchingItems(error: String)
}

class FilmesViewController: UIViewController, FilmesDisplayLogic {
    
    var interactor: FilmesBusinessLogic?
    var router: (NSObjectProtocol & FilmesRoutingLogic & FilmesDataPassing)?
    @IBOutlet weak var listaFilmes: ListaDeFilmesView!
    var viewModelInAction = [FilmesModel.Fetch.ViewModel]()
    
    func successFetchedItems(viewModel: [FilmesModel.Fetch.ViewModel]) {
        let listaDeFilmesModel = self.viewModelToListaDeFilems(viewModel: viewModel)
        listaFilmes.externalRefresh(listaDeFilmes: listaDeFilmesModel)
        viewModelInAction = viewModel
    }
    
    func viewModelToListaDeFilems(viewModel: [FilmesModel.Fetch.ViewModel]) -> [ListaDeFilmesModel] {
        var listaDeFilmes = [ListaDeFilmesModel]()
        for filmesAux in viewModel {
            var filme = ListaDeFilmesModel()
            filme.id = filmesAux.id
            filme.ano = filmesAux.ano
            filme.nome = filmesAux.nome
            filme.posterURL = filmesAux.poster
            
            listaDeFilmes.append(filme)
        }
        
        return listaDeFilmes
    }
    
    func errorFetchingItems(error: String) {
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.interactor?.fetchItems(request: FilmesModel.Fetch.Request())
        listaFilmes.delegate = self
        
    }
    
    private func setup()
    {
        // realizar o setup para o Clean.
        let viewController = self
        let interactor = FilmesInteractor()
        let presenter = FilmesPresenter()
        let router = FilmesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let viewmodel = self.getViewModelToSegue(id: sender as? Int)
        self.router?.routeToDetail(viewModel: viewmodel!, segue: segue)
    }
    
    func getViewModelToSegue(id: Int?) -> FilmesModel.Fetch.ViewModel?{
        for viewModel in viewModelInAction {
            if viewModel.id == id {
                return viewModel
            }
        }
        return nil
    }
}

extension FilmesViewController: ListaDeFilmesDelegate {
    func clickedItem(id: Int?, error: String?) {
        
        performSegue(withIdentifier: "detalheFilme", sender: id)

        
    }
    
    func endEditing(textChanged: String) {
        var search = FilmesModel.Fetch.Request()
        search.movieNameSearch = textChanged
        self.interactor?.fetchItemsSearch(request: search)
        view.endEditing(true)
    }
}
