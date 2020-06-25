//
//  CollectionViewCell.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 13/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class OnboardingViewCell: UICollectionViewCell {
    
    @IBOutlet var pageImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    var page: Page? {
        
        didSet {
            
            pageImageView.image = UIImage(named: page?.imageName ?? "")
            titleLabel.text = page?.title
            messageLabel.text = page?.message
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
