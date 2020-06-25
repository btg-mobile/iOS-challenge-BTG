//
//  HomeRouter.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 24/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    static var mainstoryboard: UIStoryboard {
        let name = "Home"
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
    static func createModule(as presentationStyle: UIModalPresentationStyle) -> UIViewController {
        
        let withIdentifier = "LoginStoryboard"
        
        guard let view = mainstoryboard.instantiateViewController(withIdentifier: withIdentifier) as? LoginViewController else {
            
            print("There was a problem presenting the selected View Controller \(withIdentifier)")
            
            return UIViewController()
        }
        
        view.modalPresentationStyle = presentationStyle
        
//        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = LoginPresenter()
//        let interactor: PresentorToInteractorProtocol = LoginInteractor()
//        let router: PresenterToRouterProtocol = LoginRouter()
        
//        view.presenter = presenter
//        presenter.view = view
//        presenter.router = router
//        presenter.interactor = interactor
//        interactor.presenter = presenter
//        interactor.view = view
        
        return view
        
    }
    
}
