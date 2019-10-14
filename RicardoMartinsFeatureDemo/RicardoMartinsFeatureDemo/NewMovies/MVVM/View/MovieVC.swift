//
//  MovieVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 13/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieVC: UIViewController {
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    fileprivate var viewModel = MovieVM()
    
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
        collectionView.anchorFillSuperView(topSafeArea: false)
        collectionView.backgroundColor = .white
        collectionView.register(MovieGroupCell.self, forCellWithReuseIdentifier: MovieGroupCell.identifier)
    }
    
    func updateVisibleFavoriteCells(){
        collectionView.visibleCells.forEach { cell in
            if let cell = cell as? MovieGroupCell{
                cell.movieHorizontalVC.updateVisibleFavoriteCells()
            }
        }
    }
    
    fileprivate func bind() {
        viewModel.multipleMovies.bind(to: collectionView.rx.items(cellIdentifier: MovieGroupCell.identifier, cellType: MovieGroupCell.self)) { row, section, cell in
                cell.section = section
            }.disposed(by: viewModel.disposeBag)
    }
}

extension MovieVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width * 0.48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 15, left: 0, bottom: 10, right: 0)
    }
}
