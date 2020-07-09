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
    
//    let movieTypeLabel = UILabel()
//    let seeDetailsLabel = UILabel()
    
    //let mainView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
      //  mainView.backgroundColor = .green
       // addSubview(mainView)
        
//        setUp()
//        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setUp() {
//
//        seeDetailsLabel.text = "See more details..."
//
//        movieTypeLabel.textColor = .label
//        seeDetailsLabel.textColor = .label
//
//    }
//
//    private func setConstraints() {
//
//        NSLayoutConstraint.activate([
//            movieTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            seeDetailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
//            //movieTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            //movieTypeLabel.topAnchor.constraint(equalTo: topAnchor),
//            //movieTypeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//
//    }
    
}
