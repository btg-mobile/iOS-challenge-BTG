//
//  MainCollectionViewCell.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 27/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private let cellId = "appCellId"
    var categorizedArray = [Movie]() {
        
        didSet {
            
            ///Set Category Type
            //categoryLabel.text = categorizedArray[0].type
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .darkBlue
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let detailsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40.0, height: 15.0))
        button.sendActions(for: .touchUpInside)
        button.setTitle("See details", for: .normal)
        button.tintColor = .darkBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    func setupViews() {
        
        layer.shadowRadius = 9
        layer.shadowOpacity = 2.3
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        addSubview(mainCollectionView)
        addSubview(categoryLabel)
        addSubview(detailsButton)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        let nibName = "MovieCollectionViewCell"
        let identifier = "MovieCell"
        [mainCollectionView].forEach { $0.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier) }
        
        detailsButton.addTarget(self, action: #selector(seeDetailsTapped), for: .touchUpInside)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": categoryLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mainCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": detailsButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mainCollectionView, "nameLabel": categoryLabel]))
        
    }
    
    @objc func seeDetailsTapped() {
        
        print("Opaa")
        
    }
    
}

extension MainCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
