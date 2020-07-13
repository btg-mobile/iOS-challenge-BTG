//
//  MainCollectionViewCell.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 27/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

protocol MainCollectionViewCellDelegate : class {
    func didTapToSeeDetails(_ section: Int)
}

class CategorySectionsCollectionViewCell: UICollectionViewCell {
    
    private let cellId = "appCellId"
    var section = 0
    var categorizedArray = [Movie]()
    
    weak var delegate: MainCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private func setUp() {
        
        addSubview(mainCollectionView)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        let nibName = "MovieCollectionViewCell"
        let identifier = "MovieCell"
        [mainCollectionView].forEach { $0.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier) }
        
        let viewDict = ["mainCollectionView": mainCollectionView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainCollectionView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainCollectionView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
        
    }
    
}

extension CategorySectionsCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categorizedArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setupCell(movie: self.categorizedArray[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width / 3.5, height: frame.height - 25)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
    }
    
}
