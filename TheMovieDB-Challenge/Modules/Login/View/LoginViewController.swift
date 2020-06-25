//
//  LoginViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 15/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController, LoginPresenterToViewProtocol {
    
    @IBOutlet weak var loginApple: UIButton!
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var loginGoogle: UIButton!
    @IBOutlet weak var loginEmail: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var mainConstraint: NSLayoutConstraint!
    
    weak var presenter: LoginViewToPresenterProtocol?
    private var cancelLoginObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        presenter?.getAppVersion()
    
    }
    
    private func setupView() {
        
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.cornerRadius = 4 }
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.borderWidth = 0.5 }
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
        
    }
    
    //Set version text
    func returnAppVersion(_ version: String) {
        self.versionLabel.text = version
    }
    
    @IBAction func signInWithApple(_ sender: UIButton) {
        
        presenter?.loginWithProvider(for: .Apple)
        
    }
    
    @IBAction func signInWithFacebook(_ sender: UIButton) {
        
        presenter?.loginWithProvider(for: .Facebook)
        
    }
    
    @IBAction func signInWithGoogle(_ sender: UIButton) {
        
        presenter?.loginWithProvider(for: .Google)
        
    }
    
    @IBAction func signInWithEmail(_ sender: UIButton) {
        
        presenter?.loginWithProvider(for: .Email)
        
    }
    
    @IBAction func createAccountLater(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: {
            
            NotificationCenter.default.post(name: .loginCancelled, object: nil)
            
        })
        
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        ///Do it later
        
    }
    
}

//MARK:- Apple Delegate for Authentication

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return view.window!

    }

}
