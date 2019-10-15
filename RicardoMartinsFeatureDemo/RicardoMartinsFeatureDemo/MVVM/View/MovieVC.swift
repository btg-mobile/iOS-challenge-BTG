//
//  MovieVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 13/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieVC: UIViewController {
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var viewModel:MovieVM!
    
    convenience init(viewModel: MovieVM){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVisibleFavoriteCells()
    }
    
    fileprivate func setupView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchorFillSuperView(topSafeArea: false)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(MovieSectionCell.self, forCellWithReuseIdentifier: MovieSectionCell.identifier)
        collectionView.register(MovieHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieHeader.identifier)
        
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
    }
    
    fileprivate func bind() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe{ [weak self] _ in
                guard let self = self else { return }
                self.viewModel.clear()
            }.disposed(by: viewModel.disposeBag)
        
        viewModel.sections
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] sections in
                guard let self = self else { return }
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }).disposed(by: viewModel.disposeBag)
    }
    
    func updateVisibleFavoriteCells(){
        collectionView.visibleCells.forEach { cell in
            if let cell = cell as? MovieSectionCell{
                cell.movieHorizontalVC.updateVisibleFavoriteCells()
            }
        }
    }
}

extension MovieVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSectionCell.identifier, for: indexPath) as? MovieSectionCell{
            let section = viewModel.sections.value[indexPath.row]
            cell.section = section
            cell.movieHorizontalVC.didSelectHandler = { [weak self] movie in
                let vc = MovieDetailVC(viewModel: MovieDetailVM(movie: movie))
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        
            return cell
        }
        
        return defaultCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width * 0.65)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieHeader.identifier, for: indexPath) as! MovieHeader
        
        header.header = viewModel.header.value
        header.movieHeaderHorizontalVC.didSelectHandler = { [weak self] movie in
            let vc = MovieDetailVC(viewModel: MovieDetailVM(movie: movie))
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        return header
    }
}

extension MovieVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width * 0.48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 15, left: 0, bottom: 10, right: 0)
    }
}
