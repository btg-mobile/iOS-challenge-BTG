//
//  Wireframe.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 17/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresentorToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func loginWithProvider(for provider: SocialLoginTypes)
    func getAppVersion()
}

protocol PresentorToInteractorProtocol: class {
    var view: LoginViewController! { get set }
    var presenter: InteractorToPresenterProtocol? { get set }
    func loginWithProvider(for provider: SocialLoginTypes)
}

protocol InteractorToPresenterProtocol: class {
    
}

protocol PresenterToViewProtocol: class {
    func returnAppVersion(_ version: String)
}

protocol PresenterToRouterProtocol: class {
    static func createModule(as presentationStyle: UIModalPresentationStyle) -> UIViewController
}
