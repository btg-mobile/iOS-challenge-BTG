//
//  LoginController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 15/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class LoginPresenter: LoginViewToPresenterProtocol, LoginInteractorToPresenterProtocol {
    
    var view: LoginPresenterToViewProtocol?
    
    var interactor: LoginPresentorToInteractorProtocol?
    
    var router: LoginPresenterToRouterProtocol?
    
    func loginWithProvider(for provider: SocialLoginTypes) {
        interactor?.loginWithProvider(for: provider)
    }
    
    func getAppVersion() {
        var versionText = ""
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionText = "v\(version)"
            
            #if DEBUG
            if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                versionText += "-\(build)"
            }
            #endif
            
        } else {
            versionText = ""
        }
        
        view?.returnAppVersion(versionText)
        
    }
    
}
