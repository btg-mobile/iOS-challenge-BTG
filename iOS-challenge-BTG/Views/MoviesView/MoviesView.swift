//
//  MoviesView.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 17/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit

protocol MoviesViewInteractionLogic: class {
    func didSelect(movie: Movie)
    func loadMoreData()
    func refreshContent()
}

class MoviesView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    private let cellIdentifier = "MoviesCollectionViewCell"
    var movies: [Movie] = []
    weak var viewController: MoviesViewInteractionLogic?

    // MARK: - Object lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        setupView()
        setupCollectionView()
    }

    private func setupView() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("MoviesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self

        let itemWidth = UIScreen.main.bounds.width/2 - 24
        let heightProportion = CGFloat(1.83)
        let itemHeight = itemWidth * heightProportion

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)

        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)

        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 30

        collectionView.collectionViewLayout = layout

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Constants.color().lightGreen
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    // MARK: - Collection view data source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as! MoviesCollectionViewCell

        cell.setupCell(with: movies[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = viewController {
            viewController.didSelect(movie: movies[indexPath.row])
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            if let viewController = viewController {
                viewController.loadMoreData()
            }
        }
    }

    // MARK: - Actions

    @objc func refreshContent() {
        if let viewController = viewController {
            viewController.refreshContent()
        }
    }
}
