//
//  MovieHeaderHorizontalVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 14/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieHeaderHorizontalVC: UIViewController {
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    fileprivate let numberOfVisibleCells: CGFloat = 1.05
    fileprivate let secttionPadding:UIEdgeInsets = .init(top: 10, left: 15, bottom: 10, right: 15)
    fileprivate let lineSpace: CGFloat = 15
    fileprivate var numberOfSpacesBetweenCells: CGFloat {
        return numberOfVisibleCells > 1 ? (numberOfVisibleCells - 1) : numberOfVisibleCells
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    fileprivate func setupView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchorFillSuperView()
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(MovieHeaderCell.self, forCellWithReuseIdentifier: MovieHeaderCell.identifier)
  
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
}

extension MovieHeaderHorizontalVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieHeaderCell.identifier, for: indexPath) as! MovieHeaderCell
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.section.value.movies.count + 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
//
//        if(indexPath.row == viewModel.section.value.movies.count){
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieLoadingCell.identifier, for: indexPath) as? MovieLoadingCell {
//                return cell
//            }
//        }else{
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieHorizontalCell.identifier, for: indexPath) as? MovieHorizontalCell {
//                let movie = viewModel.section.value.movies[indexPath.row]
//                cell.viewModel = MovieDetailVM(movie: movie)
//                return cell
//            }
//        }
//
//        return defaultCell
//    }
}

extension MovieHeaderHorizontalVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpace
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - secttionPadding.left - secttionPadding.right - (numberOfSpacesBetweenCells * lineSpace)) / numberOfVisibleCells
        let height = view.frame.height - secttionPadding.top - secttionPadding.bottom
        return .init(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return secttionPadding
    }
}

