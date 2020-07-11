//
//  SettingsViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 18/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import GoogleSignIn

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedToLogOut(_ sender: UIButton) {
        
        guard let signIn = GIDSignIn.sharedInstance() else { return }
        
        if (signIn.hasPreviousSignIn()) {
            signIn.signOut()
        }else {
            print("usuário não está logado.")
        }
        
    }
    
}

extension SettingsViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        print("Google user was disconnected")
        
    }
    
}
