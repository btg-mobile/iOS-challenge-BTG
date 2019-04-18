//
//  FilmesRouter.swift
//  TheMovieDB
//
//  Created by Eric Soares Filho on 15/04/19.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit

protocol FilmesRoutingLogic
{
    func routeToDetail(viewModel: FilmesModel.Fetch.ViewModel, segue: UIStoryboardSegue?)
}

protocol FilmesDataPassing
{
    var dataStore: FilmesDataStore? { get }
}

class FilmesRouter: NSObject, FilmesRoutingLogic, FilmesDataPassing
{
    weak var viewController: FilmesViewController?
    var dataStore: FilmesDataStore?
    
    func routeToDetail(viewModel: FilmesModel.Fetch.ViewModel, segue: UIStoryboardSegue?) {
        
        let destinationVC = segue?.destination as! FilmesDetalheViewController
        destinationVC.fromViewModel = viewModel
        //passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    }
    
    /*func passDataToDetalhesFIlmes(source: FilmesDataStore, destination: inout FimesDetalhesDataStore)
    {
        destination.name = source.name
    }*/
}
