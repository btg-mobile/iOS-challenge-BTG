//
//  favoriteButton.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    override func didMoveToSuperview() {
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.black, for: .selected)
        
        self.setTitle("Faved", for: .selected)
        self.setTitle("Fave", for: .normal)

    }
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .white : .black
        }
    }
    
    
    

}
