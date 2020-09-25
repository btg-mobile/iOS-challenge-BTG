//
//  HomeSectionHeaderView.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 07/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class HomeSectionHeaderView : UICollectionReusableView {
    
    static let reuseIdentifier = "HomeSectionHeaderView"
    
    weak var delegate: MainCollectionViewCellDelegate?
    
    var selectedSection: Int?
    
    let movieTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white//.label
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Movies"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let seeDetailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white//.label
        label.text = "See more details..."
        label.font = UIFont.italicSystemFont(ofSize: 14) //boldSystemFont(ofSize: 14)
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
    
    @objc fileprivate func didTapToSeeDetails( _ Label: UILabel) {
        
        if let section = selectedSection {
            
            delegate?.didTapToSeeDetails(section)
            
        }
        
    }
    
    private func setUp() {
        
        //layer.shadowRadius = 5
        //layer.shadowOpacity = 2.3
        //layer.shadowColor = UIColor.darkGray.cgColor
        //layer.shadowOffset = CGSize(width: 5, height: 8)
        backgroundColor = #colorLiteral(red: 0.01234783977, green: 0.1457155645, blue: 0.254773736, alpha: 1)
        
        addSubview(movieTypeLabel)
        addSubview(seeDetailsLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapToSeeDetails(_:)))
        seeDetailsLabel.addGestureRecognizer(tap)
        seeDetailsLabel.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            movieTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieTypeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeDetailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            seeDetailsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
}
