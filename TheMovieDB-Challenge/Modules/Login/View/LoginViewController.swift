//
//  LoginViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 15/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import AuthenticationServices
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginApple: UIButton!
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var loginGoogle: UIButton!
    @IBOutlet weak var loginEmail: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var mainConstraint: NSLayoutConstraint!
    
    //var controller = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupView()
        
        if let token = AccessToken.current, !token.isExpired {
            
            // User is logged in, do work such as go to next view controller.
            
        }
            
    }
    
    func setupView() {
        mainConstraint.constant = -300
        
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.cornerRadius = 4 }
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.borderWidth = 0.5 }
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
        
        UIView.animate(withDuration: 0.5) {
            
            self.mainConstraint.constant = 32
            
        }
        
        setVersionLabelText()
        
    }
    
    //Set version text
    private func setVersionLabelText() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            var versionText = "v\(version)"
            
            #if DEBUG
            if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                versionText += "-\(build)"
            }
            #endif
            
            versionLabel.text = versionText
            versionLabel.isHidden = false
        } else {
            versionLabel.isHidden = true
        }
    }
    
    @IBAction func signInWithApple(_ sender: UIButton) {
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
        
    }
    
    @IBAction func signInWithFacebook(_ sender: UIButton) {
        
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self ) { (result, error) -> Void in
            if (error == nil) {
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)! {
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email")) {
                    //self.getFBUserData()
                }
            }
        }
        
    }
    
    @IBAction func signInWithGoogle(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        guard let signIn = GIDSignIn.sharedInstance() else { return }
        
        if (signIn.hasPreviousSignIn()) {
            signIn.signOut()
            
        }
        
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    @IBAction func signInWithEmail(_ sender: UIButton) {

        //
        
    }
    
    @IBAction func createAccountLater(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: {
            
            NotificationCenter.default.post(name: .loginCancelled, object: nil)
            
        })
        
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
    }
    
}

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard error == nil else {
            if let error = error {
                print("Failed to sign in with Google: \(error)")
            }
            return
        }
        
        self.dismiss(animated: true, completion: {
            
            NotificationCenter.default.post(name: .loginCancelled, object: nil)
            
        })
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        print(credential)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        print("Google user was disconnected")
        
    }
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = LoginSocialEntity()
            
            user.id = credentials.user
            user.GivenName = credentials.fullName?.givenName
            user.FamilyName = credentials.fullName?.familyName
            user.Email = credentials.email

        default: break
            
        }

    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("something bad happened", error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return view.window!

    }

}
