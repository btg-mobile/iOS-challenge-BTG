//
//  HomeViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 08/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseCrashlytics
import GoogleSignIn

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    weak var presenter: HomeViewToPresenterProtocol?
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeRouter.initModule(from: self)
        
        LoadingView.sharedInstance.show()
        
        addRefreshingControl()
        
        presenter?.requestFirstCallOfMovies()
        
        setUp()
        
        registerCells()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        guard let signIn = GIDSignIn.sharedInstance() else { return }
        
        if !signIn.hasPreviousSignIn() {
            
            perform(#selector(shouldShowOnboarding), with: self, afterDelay: 1)
            
        }
        
    }
    
    @objc func shouldShowOnboarding() {
        
        let identifier = "OnboardingViewControllerIdentifier"
        
        let homeStoryboard = UIStoryboard.init(name: "Onboarding", bundle: nil)
        
        let onbordingViewController = homeStoryboard.instantiateViewController(withIdentifier: identifier)
        
        self.present(onbordingViewController, animated: true)
        
    }
    
    private func setUp() {
        
        mainCollectionView.showsVerticalScrollIndicator = false
        
        ///Delegate and DataSource methods
        [mainCollectionView].forEach { (collectionView) in
            
            collectionView?.delegate = self
            collectionView?.dataSource = self
            
        }
        
    }
    
    //MARK: - Register Cells
    fileprivate func registerCells() {
        
        let cellID = "MainCollectionViewCellID"
        mainCollectionView.register(CategorySectionsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        mainCollectionView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier)
        
    }
    
    //MARK: - Sets the StatusBar as white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
        
    }
    
    //MARK: - TapGestures
    @IBAction func tapToSeeMorePopularMovies(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "Movies", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MoviesList") as! MovieViewController
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    private func addRefreshingControl() {
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .lightGreen
        self.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.mainCollectionView.addSubview(refreshControl ?? UIView())
        
    }
    
    @objc private func refreshList() {
        
        refreshControl?.endRefreshing()
        
        presenter?.requestFirstCallOfMovies()
        
    }
    
}

//MARK: - CollectionView Methods Extension
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        ///Main Screen has only one section now // Series will come afterwards
        return presenter?.numberOfSections() ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1//presenter?.getNumberOfRowsInSection(section: section) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier, for: indexPath) as! HomeSectionHeaderView
        
        return sectionHeaderView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 30.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let withReuseIdentifier = "MainCollectionViewCellID"
        
        let cell: CategorySectionsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as! CategorySectionsCollectionViewCell
        
        if let arrayMovies = presenter?.loadMovieArrayWithIndexPath(indexPath: indexPath) {
            
            cell.categorizedArray = arrayMovies
            
        }
        
        //cell.categoryLabel.text = presenter?.getCategoryName(section: indexPath.row)
        cell.section = indexPath.row
        cell.delegate = self
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Details", bundle: nil)
        
        let vc: DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewControllerID") as! DetailsViewController
        
        vc.movie = presenter?.loadMovieWithIndexPath(indexPath: indexPath)
        
        present(vc, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
    }
    
}

//MARK: - Controller Protocol Methods

extension HomeViewController: HomePresenterToViewProtocol {
    
    func showMovieResults() {
        
        DispatchQueue.main.async {
            LoadingView.sharedInstance.hide()
            self.mainCollectionView.reloadData()
        }
        
    }
    
    func problemOnFetchingData(error: Constants.errorTypes) {
        
        ///Show Alert with problem
        
    }
    
}

//MARK: - MainCollectionViewCellDelegate Protocol Methods

extension HomeViewController: MainCollectionViewCellDelegate {
    
    func didTapToSeeDetails(_ section: Int) {
        
        let movieStoryboard = UIStoryboard.init(name: "Movies", bundle: Bundle.main)
        
        let vc = movieStoryboard.instantiateViewController(withIdentifier: "MoviesList")
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
