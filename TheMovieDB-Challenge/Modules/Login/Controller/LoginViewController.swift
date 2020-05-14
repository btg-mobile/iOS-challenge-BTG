//
//  ViewController.swift
//  ViNaTV
//
//  Created by Alan Silva on 27/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class LoginViewController: UINavigationController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var headConstraint: NSLayoutConstraint!
    @IBOutlet weak var centralView: UIView!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var loginGoogle: UIButton!
    @IBOutlet weak var loginApple: UIButton!
    @IBOutlet weak var loginEmail: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additionalsetup after loading the view.
        
        //setupView()
    }
    
    func setupView(){
        
        loginGoogle.layer.cornerRadius = 4
        loginFacebook.layer.cornerRadius = 4
        loginApple.layer.cornerRadius = 4
        loginEmail.layer.cornerRadius = 4

        loginGoogle.layer.borderWidth = 0.5
        loginGoogle.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func signInWithFacebook(_ sender: UIButton) {
    
        
    
    }
    
    @IBAction func signInWithGoogle(_ sender: UIButton) {
    
        
    
    }

    @IBAction func signInWithApple(_ sender: UIButton) {
    
        
    
    }
    
    @IBAction func signInWithEmail(_ sender: UIButton) {
    
        
    
    }
    
    @IBAction func createAccountLater(_ sender: UIButton) {
        
        // self.present(mainVC, animated: true)
    
    }

    @IBAction func createAccount(_ sender: UIButton) {
    
        
    
    }
    

}
