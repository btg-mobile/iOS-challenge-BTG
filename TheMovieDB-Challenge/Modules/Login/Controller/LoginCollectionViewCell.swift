//
//  LoginCollectionViewCell.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 14/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var loginApple: UIButton!
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var loginGoogle: UIButton!
    @IBOutlet weak var loginEmail: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
        
    }

    func setupView() {
        
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.cornerRadius = 4 }
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.borderWidth = 0.5 }
        [loginGoogle, loginFacebook, loginApple, loginEmail].forEach { $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}

    }
    
    @IBAction func signInWithApple(_ sender: UIButton) {
    
    }
    
    @IBAction func signInWithFacebook(_ sender: UIButton) {
    
    }
    
    @IBAction func signInWithGoogle(_ sender: UIButton) {
    
    }
    
    @IBAction func signInWithEmail(_ sender: UIButton) {
    
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
    
    }
    
    @IBAction func createAccountLater(_ sender: UIButton) {
        
        // self.present(mainVC, animated: true)
    
    }
    
}
