//
//  MoviesFavoriteVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesFavoriteVC: UIViewController {
    let tableView = UITableView()
    
    let noResultsAnimationView = NoResultsAnimationView()
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel = FavoriteVM()
    
    convenience init(viewModel:FavoriteVM){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchBar()
        setupNoResultsAnimationView()
        setupBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavorites()
    }
    
    fileprivate func setupBind() {
        viewModel.isHiddenNoResults
            .bind(to: noResultsAnimationView.rx.isHidden)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.noResultType
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] type in
                self?.noResultsAnimationView.setText(type: type)
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.favorites
            .bind(to: tableView.rx.items(cellIdentifier: MovieFavoriteCell.identifier, cellType: MovieFavoriteCell.self)) {  (row, movie, cell) in
                cell.favoriteButtonVM = FavoriteButtonVM(movie: movie)
            }.disposed(by: viewModel.disposeBag)
        
        searchController.searchBar.rx.selectedScopeButtonIndex
            .subscribe(onNext: { [weak self] index in
                self?.viewModel.order.accept(index)
                self?.viewModel.getFavorites()
            }).disposed(by: viewModel.disposeBag)
        
        searchController.searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.searchController.searchBar.text = ""
            }).disposed(by: viewModel.disposeBag)
        
        searchController.searchBar
            .rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.searchMovies(query: query)
            }).disposed(by: viewModel.disposeBag)
        
        tableView.rx.itemDeleted
            .subscribe { [weak self] indexPath in
                guard let self = self else { return }
            
                if let indexPath = indexPath.element, let cell = self.tableView.cellForRow(at: indexPath) as? MovieFavoriteCell{
                    cell.favoriteButtonVM.isFavorited.accept(false)
                    cell.favoriteButtonVM.setFavorite()
                    self.viewModel.getFavorites()
                }
            }
            .disposed(by:  viewModel.disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let favorite = self.viewModel.favorites.value[indexPath.row]
                let vc = MovieDetailVC(viewModel: MovieDetailVM(movie: favorite))
                
                if(self.searchController.isActive){
                    self.searchController.isActive = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                        self?.navigationController?.pushViewController(vc, animated: true)
                    })
                }else{
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: viewModel.disposeBag)
    }
    
    fileprivate func searchMovies(query:String){
        viewModel.query.accept(query)
        viewModel.favorites.accept([])
        viewModel.getFavorites()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.tintColor = .black
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar filmes favoritos"
        searchController.searchBar.scopeButtonTitles = ["A -> Z", "Z -> A"]
        searchController.searchBar.showsScopeBar = true
    }
    
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.anchorFillSuperView()
        tableView.rowHeight = view.frame.width / 4
        tableView.keyboardDismissMode = .onDrag
        tableView.register(MovieFavoriteCell.self, forCellReuseIdentifier: MovieFavoriteCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNoResultsAnimationView(){
        view.addSubview(noResultsAnimationView)
        noResultsAnimationView.anchor(
            centerX: (view.centerXAnchor, 0),
            top: (tableView.topAnchor, 30),
            width: view.frame.width - 100,
            height: 200
        )
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
    }
}
