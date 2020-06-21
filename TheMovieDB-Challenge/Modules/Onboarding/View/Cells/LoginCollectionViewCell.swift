//
//  LoginCollectionViewCell.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 14/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

protocol LoginCollectionViewCellDelegate: class {
    func openLogin()
    func closeView()
}

class LoginCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var loginNowButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var delegate: LoginCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
        
    }
    
    private func setupView() {
        
        [loginNowButton, loginButton].forEach { $0.layer.cornerRadius = 8 }
        [loginNowButton, loginButton].forEach { $0.layer.borderWidth = 0.5 }
        [loginNowButton, loginButton].forEach { $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
        
    }
    
    @IBAction func signInNowButton(_ sender: UIButton) {
        
        self.delegate?.openLogin()
        
    }
    
    @IBAction func signInLaterButton(_ sender: UIButton) {
        
        self.delegate?.closeView()
        
    }
    
}
