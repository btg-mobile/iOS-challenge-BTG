//
//  MovieDetailVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class MovieDetailVC: UIViewController {
    let tableView = UITableView()
    let headerView = MovieDetailHeaderView()
    
    var viewModel = MovieDetailVM(movie: nil)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    convenience init(viewModel:MovieDetailVM){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkIsFavorited()
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
    }

    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.anchorFillSuperView(topSafeArea: false)
        tableView.separatorStyle = . none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.register(MovieDetailInfoCell.self, forCellReuseIdentifier: MovieDetailInfoCell.identifier)
        tableView.register(MovieDetailOverviewCell.self, forCellReuseIdentifier: MovieDetailOverviewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        tableView.tableHeaderView?.addSubview(headerView)

        headerView.anchor(
            top: (view.topAnchor, 0),
            left: (tableView.tableHeaderView!.leftAnchor, 0),
            right: (tableView.tableHeaderView!.rightAnchor, 0),
            bottom: (tableView.tableHeaderView!.bottomAnchor, 0)
        )
    }

    fileprivate func setupBind() {
        viewModel.loading
            .bind(to: rx.isAnimating)
            .disposed(by: viewModel.disposeBag)
        
        headerView.backButton.rx.tap
            .bind { [weak self] in
                self?.didPop()
            }.disposed(by: viewModel.disposeBag)

        viewModel.genres
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] genres in
                guard let self = self else { return }
                self.viewModel.heightHeaderRelative.accept(self.view.frame.height * 0.3)
                self.headerView.viewModel = self.viewModel
                self.view.bringSubviewToFront(self.headerView)
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.fields.bind(to: tableView.rx.items){[weak self] (tv, row, field) -> UITableViewCell in
            tv.rowHeight = 0
            let defaultCell = tv.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: IndexPath.init(row: row, section: 0))
            
            guard let self = self else { return defaultCell }
            let relativeHeithRow = UIScreen.main.bounds.width / 4
            
            switch field {
            case .info:
                if let cell = tv.dequeueReusableCell(withIdentifier: MovieDetailInfoCell.identifier, for: IndexPath.init(row: row, section: 0)) as? MovieDetailInfoCell {
                    tv.estimatedRowHeight = relativeHeithRow
                    tv.rowHeight = UITableView.automaticDimension
                    cell.viewModel = self.viewModel
                    return cell
                }
            case .overview:
                if let cell = tv.dequeueReusableCell(withIdentifier: MovieDetailOverviewCell.identifier, for: IndexPath.init(row: row, section: 0)) as? MovieDetailOverviewCell {
                    tv.estimatedRowHeight = 44
                    tv.rowHeight = UITableView.automaticDimension
                    cell.viewModel = self.viewModel
                    return cell
                }
            }
            return defaultCell
            }.disposed(by: viewModel.disposeBag)
    }
}

