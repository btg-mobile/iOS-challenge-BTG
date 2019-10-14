//
//  MovieHorizontalVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 13/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieHorizontalVC: UIViewController {
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    fileprivate let numberOfVisibleCells: CGFloat = 3.2
    fileprivate let secttionPadding:UIEdgeInsets = .init(top: 10, left: 15, bottom: 10, right: 15)
    fileprivate let lineSpace: CGFloat = 15
    fileprivate var numberOfSpacesBetweenCells: CGFloat {
        return numberOfVisibleCells > 1 ? (numberOfVisibleCells - 1) : numberOfVisibleCells
    }
    
    var viewModel: MovieHorizontalVM!{
        didSet{
            bind()
        }
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
        collectionView.register(MovieCell2.self, forCellWithReuseIdentifier: MovieCell2.identifier)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func updateVisibleFavoriteCells(){
        collectionView.visibleCells.forEach { cell in
            if let cell = cell as? MovieCell{
                cell.checkIsFavorited()
            }
        }
    }
    
    fileprivate func bind() {
        viewModel.movies
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] sections in
                self?.collectionView.reloadData()
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                // No need to present a message to the user
            }).disposed(by: viewModel.disposeBag)
    }
}

extension MovieHorizontalVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell2.identifier, for: indexPath) as! MovieCell2
        let movie = viewModel.movies.value[indexPath.row]
        cell.viewModel = MovieDetailVM(movie: movie)
        return cell
    }
}

extension MovieHorizontalVC: UICollectionViewDelegateFlowLayout {
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
