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
    
    var didSelectHandler: ((Movie) -> ())?
    
    var viewModel:MovieHorizontalVM!{
        didSet{
            bind()
            viewModel.getMovies()
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(MovieHorizontalCell.self, forCellWithReuseIdentifier: MovieHorizontalCell.identifier)
        collectionView.register(MovieLoadingCell.self, forCellWithReuseIdentifier: MovieLoadingCell.identifier)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func updateVisibleFavoriteCells(){
        collectionView.visibleCells.forEach { cell in
            if let cell = cell as? MovieHorizontalCell{
                cell.checkIsFavorited()
            }
        }
    }
    
    fileprivate func nextPage(currentRow:Int){
        let page = viewModel.section.value.page
        let totalPage = viewModel.section.value.totalPages
        
        let isEndList = currentRow >= viewModel.section.value.movies.count - 1
        let isEndPagination = page == totalPage
        
        if(isEndList && !isEndPagination){ self.viewModel.getMovies() }
    }
    
    fileprivate func bind() {
        viewModel.section
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] sections in
                self?.collectionView.reloadData()
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                // No need to present a message to the user
            }).disposed(by: viewModel.disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let movie = self.viewModel.section.value.movies[indexPath.row]
                self.didSelectHandler?(movie)
            }).disposed(by: viewModel.disposeBag)
        
        collectionView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                guard let self = self else { return }
                cell.alpha = 0
                cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 150, 0)
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: { ( _ ) in
                    self.nextPage(currentRow: indexPath.row)
                })
            }).disposed(by: viewModel.disposeBag)
        
    }
}

extension MovieHorizontalVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.section.value.movies.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
        
        if(indexPath.row == viewModel.section.value.movies.count){
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieLoadingCell.identifier, for: indexPath) as? MovieLoadingCell {
                return cell
            }
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieHorizontalCell.identifier, for: indexPath) as? MovieHorizontalCell {
                let movie = viewModel.section.value.movies[indexPath.row]
                cell.viewModel = MovieDetailVM(movie: movie)
                return cell
            }
        }

        return defaultCell
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
