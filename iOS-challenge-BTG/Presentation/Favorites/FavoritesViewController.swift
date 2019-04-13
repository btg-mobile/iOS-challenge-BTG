//
//  FavoritesViewController.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright (c) 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import UIKit

// MARK: - Typealias

// MARK: - Protocols
protocol FavoritesDisplayLogic: class {
    func displaySomething(viewModel: Favorites.ViewModel)
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    
    static func instantiate() -> FavoritesViewController {
        let vc = FavoritesViewController(nibName: String(describing: FavoritesViewController.self), bundle: nil)
        return vc
    }
    
    // MARK: - Propriedades (Getters & Setters)
    
    // MARK: - Outlets
    
    // MARK: - Vars
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?
    
    // MARK: - Lets
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        doSomething()
    }
    
    // MARK: - Public Methods
    func doSomething() {
        let request = Favorites.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Favorites.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    // MARK: - Private Methods
    private func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Deinitializers
}

// MARK: - Extensions
