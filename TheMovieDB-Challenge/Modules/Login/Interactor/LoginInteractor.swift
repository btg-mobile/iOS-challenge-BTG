//
//  LoginInteractor.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 17/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
import AuthenticationServices
import FBSDKLoginKit

class LoginInteractor: NSObject, PresentorToInteractorProtocol {
    
    var view: LoginViewController!
    var presenter: InteractorToPresenterProtocol?
    
    //        if let token = AccessToken.current, !token.isExpired {
    //
    //            // User is logged in, do work such as go to next view controller.
    //
    //        }
    
    func loginWithProvider(for provider: SocialLoginTypes) {
        
        switch provider {
        case .Apple:
            print("Apple")
            openLoginWithApple(self.view)
        case .Facebook:
            print("Facebok")
            openLoginWithFacebook(self.view)
        case .Google:
            print("Google")
            openLoginWithGoogle(self.view)
        case .Email:
            print("Email")
            openLoginWithEmail(self.view)
        }
        
    }
    
    //MARK: - INDIVIDUAL METHODS
    
    private func openLoginWithApple(_ view: UIViewController) {
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self.view
        
        controller.performRequests()
        
    }
    
    private func openLoginWithFacebook(_ view: UIViewController) {
        
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: view ) { (result, error) -> Void in
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
    
    private func openLoginWithGoogle(_ view: UIViewController) {
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = view
        
        guard let signIn = GIDSignIn.sharedInstance() else { return }
        
        if (signIn.hasPreviousSignIn()) {
            signIn.signOut()
            
        }
        
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    private func openLoginWithEmail(_ view: UIViewController) {
        
    }
    
}

extension LoginInteractor: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard error == nil else {
            if let error = error {
                print("Failed to sign in with Google: \(error)")
            }
            return
        }
        
        //Login com sucesso. Dismiss a tela de login anterior
        
        self.view.dismiss(animated: true, completion: {
            
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

extension LoginInteractor: ASAuthorizationControllerDelegate {

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
