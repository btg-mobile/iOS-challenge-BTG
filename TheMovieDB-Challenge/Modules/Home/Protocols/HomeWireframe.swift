//
//  HomeWireframe.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 24/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

import UIKit

protocol HomeViewToPresenterProtocol: class {
//    var view: PresenterToViewProtocol? { get set }
//    var interactor: PresentorToInteractorProtocol? { get set }
//    var router: PresenterToRouterProtocol? { get set }
//    func loginWithProvider(for provider: SocialLoginTypes)
}

protocol HomePresentorToInteractorProtocol: class {
//    var view: LoginViewController! { get set }
//    var presenter: InteractorToPresenterProtocol? { get set }
//func loginWithProvider(for provider: SocialLoginTypes)
}

protocol HomeInteractorToPresenterProtocol: class {
    
}

protocol HomePresenterToViewProtocol: class {
    //func returnAppVersion(_ version: String)
}

protocol HomePresenterToRouterProtocol: class {
    static var mainstoryboard: UIStoryboard { get }
    static func createModule(as presentationStyle: UIModalPresentationStyle) -> UIViewController
}
