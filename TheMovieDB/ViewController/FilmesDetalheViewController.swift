//
//  FilmesDetalheViewController.swift
//  TheMovieDB
//
//  Created by Eric Soares Filho on 15/04/19.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit

class FilmesDetalheViewController: UIViewController {

    var fromViewModel = FilmesModel.Fetch.ViewModel()
    @IBOutlet weak var detalhesView: DetalhesFilmeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detalhesView.generalInits(id: fromViewModel.id, titulo: fromViewModel.nome!, nota: "", imagemURL: fromViewModel.poster!, Sinopse: fromViewModel.sinopse!)
        // Do any additional setup after loading the view.
    }
}
