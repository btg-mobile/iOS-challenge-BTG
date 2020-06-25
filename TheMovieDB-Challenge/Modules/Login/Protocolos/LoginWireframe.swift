//
//  Wireframe.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 17/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewToPresenterProtocol: class {
    var view: LoginPresenterToViewProtocol? { get set }
    var interactor: LoginPresentorToInteractorProtocol? { get set }
    var router: LoginPresenterToRouterProtocol? { get set }
    func loginWithProvider(for provider: SocialLoginTypes)
    func getAppVersion()
}

protocol LoginPresentorToInteractorProtocol: class {
    var view: LoginViewController! { get set }
    var presenter: LoginInteractorToPresenterProtocol? { get set }
    func loginWithProvider(for provider: SocialLoginTypes)
}

protocol LoginInteractorToPresenterProtocol: class {
    
}

protocol LoginPresenterToViewProtocol: class {
    func returnAppVersion(_ version: String)
}

protocol LoginPresenterToRouterProtocol: class {
    static func createModule(as presentationStyle: UIModalPresentationStyle) -> UIViewController
}
