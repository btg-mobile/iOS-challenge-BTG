//
//  MoviesPopularVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesPopularVC: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let noResultsAnimationView = NoResultsAnimationView()
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel = MovieVM()
    
    convenience init(viewModel:MovieVM){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupSearchBar()
        setupNoResultsAnimationView()
        setupBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVisibleFavoriteCells()
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
    }
    
    fileprivate func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.anchorFillSuperView()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            
            layout.itemSize  = {
                let width = (view.frame.width - 30) / 2
                var height:CGFloat = 0
                
                switch UIDevice.screenType {
                case .iPhone_XR, .iPhone_XSMax:
                     height = width * 1.55
                case .iPhones_X_XS:
                    height = width * 1.50
                case .iPhones_6_6s_7_8, .iPhones_6Plus_6sPlus_7Plus_8Plus:
                    height = width * 1.65
                case .iPhones_4_4S, .iPhones_5_5s_5c_SE:
                    height = width * 1.60
                default:
                    height = width * 1.55
                }
                
                return .init(width: width, height: height)
            }()
        }
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = navigationController?.navigationBar.backgroundColor
        collectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.tintColor = .black
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = String.Localizable.app.getValue(code: 4)
    }
    
    fileprivate func nextPage(currentRow:Int){
        let isEndList = currentRow >= self.viewModel.movies.value.count - 1
        let isEndPagination = self.viewModel.page.value == self.viewModel.totalPage.value
        if(isEndList && !isEndPagination){ self.viewModel.getMovies() }
    }
    
    fileprivate func searchMovies(query:String){
        viewModel.query.accept(query)
        viewModel.page.accept(0)
        viewModel.movies.accept([])
        viewModel.getMovies()
    }
    
    fileprivate func setupNoResultsAnimationView(){
        noResultsAnimationView.setText(type: .noResultsInSearch)
        view.addSubview(noResultsAnimationView)
        noResultsAnimationView.anchor(
            centerX: (view.centerXAnchor, 0),
            top: (collectionView.topAnchor, 30),
            width: view.frame.width - 100,
            height: 200
        )
    }
    
    fileprivate func updateVisibleFavoriteCells(){
        collectionView.visibleCells.forEach { cell in
            if let cell = cell as? MovieCell{
                cell.favoriteButton.favoriteButtonVM.checkIsFavorited()
            }
        }
    }
    
    fileprivate func setupBind() {
        viewModel.loading
            .bind(to: rx.isAnimating)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.isHiddenNoResults
            .bind(to: noResultsAnimationView.rx.isHidden)
            .disposed(by: viewModel.disposeBag)
        
        searchController.searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.searchMovies(query: query)
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                debugPrint(error)
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.movies.bind(to: collectionView.rx.items){ (cl, row, movie) -> UICollectionViewCell in
            if let cell = cl.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: IndexPath.init(row: row, section: 0)) as? MovieCell{
                cell.viewModel = MovieDetailVM(movie: movie)
                return cell
            }else{
                let defaultCell = cl.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: IndexPath.init(row: row, section: 0))
                return defaultCell
            }
            }.disposed(by: viewModel.disposeBag)
        
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let movie = self.viewModel.movies.value[indexPath.row]
                let vc = MovieDetailVC(viewModel: MovieDetailVM(movie: movie))
                
                if(self.searchController.isActive){
                    self.searchController.isActive = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                        self?.navigationController?.pushViewController(vc, animated: true)
                    })
                }else{
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: viewModel.disposeBag)
        
        collectionView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                guard let self = self else { return }
                
                if(self.viewModel.page.value == 1 && indexPath.row <= 3){
                    cell.alpha = 0
                    cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 150, 0)
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        cell.alpha = 1
                        cell.layer.transform = CATransform3DIdentity
                    }, completion: { ( _ ) in
                        self.nextPage(currentRow: indexPath.row)
                    })
                }else{
                    self.nextPage(currentRow: indexPath.row)
                }
            }).disposed(by: viewModel.disposeBag)
    }
}
