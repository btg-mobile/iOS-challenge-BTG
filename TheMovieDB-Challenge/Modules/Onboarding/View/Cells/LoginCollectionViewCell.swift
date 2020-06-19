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
    @IBOutlet weak var versionLabel: UILabel!
    
    weak var delegate: LoginCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
        
    }
    
    func setupView() {

        loginNowButton.layer.cornerRadius = 8
        loginNowButton.layer.borderWidth = 0.5
        loginNowButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        loginButton.layer.cornerRadius = 8
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
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

    @IBAction func signInNowButton(_ sender: UIButton) {
            
        self.delegate?.openLogin()
        
    }
    
    @IBAction func signInLaterButton(_ sender: UIButton) {
        
        self.delegate?.closeView()
        
    }
    
}
