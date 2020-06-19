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
    func updateView()
}

protocol PresentorToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetchLiveNews()
}

protocol InteractorToPresenterProtocol: class {
    func liveNewsFetched(login: LoginSocialEntity)
    func liveNewsFetchedFailed()
}

protocol PresenterToViewProtocol: class {
    func showNews(login: LoginSocialEntity)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}
