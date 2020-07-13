//
//  HomeSectionHeaderView.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 07/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

class HomeSectionHeaderView : UICollectionReusableView {
        
    static let reuseIdentifier = "HomeSectionHeaderView"
    
    let movieTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Movies"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let seeDetailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "See more details..."
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
        layer.shadowRadius = 5
        layer.shadowOpacity = 2.3
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 8)
        backgroundColor = #colorLiteral(red: 0.9212601165, green: 0.9303815038, blue: 0.9303815038, alpha: 1)
        
        addSubview(movieTypeLabel)
        addSubview(seeDetailsLabel)
        
        NSLayoutConstraint.activate([
            movieTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieTypeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeDetailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            seeDetailsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

    }

}
