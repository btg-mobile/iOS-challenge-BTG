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
        backgroundColor = .red
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    let categoryLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        label.textColor = .darkBlue
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//    let seeDetailsLabel: UILabel = {
//        let label = UILabel()
//        label.text = "VEjs more details..."
//        label.textColor = .darkBlue
//        label.sizeToFit()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private func setupViews() {
        
        layer.shadowRadius = 9
        layer.shadowOpacity = 2.3
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        addSubview(mainCollectionView)
//        addSubview(categoryLabel)
//        addSubview(seeDetailsLabel)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        let nibName = "MovieCollectionViewCell"
        let identifier = "MovieCell"
        [mainCollectionView].forEach { $0.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier) }
        
        //let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.seeDetailsTapped))
//        seeDetailsLabel.isUserInteractionEnabled = true
//        seeDetailsLabel.addGestureRecognizer(labelTapGesture)
        
//        let viewDict = ["categoryLabel": categoryLabel, "seeDetailsLabel": seeDetailsLabel, "mainCollectionView": mainCollectionView]
//
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[categoryLabel]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[seeDetailsLabel]-8-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainCollectionView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[categoryLabel(30)][mainCollectionView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[seeDetailsLabel(30)][mainCollectionView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
  
        let viewDict = ["mainCollectionView": mainCollectionView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainCollectionView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainCollectionView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
        
    }
    
    @objc func seeDetailsTapped() {
        
        delegate?.didTapToSeeDetails(section)
        
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
        
        return CGSize(width: frame.width / 3.5, height: frame.height - 32)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
    }
    
}
