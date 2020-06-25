//
//  HomeViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 08/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseCrashlytics

class MovieViewController: UIViewController {
    
    var controller : MovieController?
    var refreshControl: UIRefreshControl?
    var fetchingMore = false
    var noticeNoMoreData = false
    var movieSelection: Constants.MovieSelection?
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchBarHight: NSLayoutConstraint!
    @IBOutlet weak var loadingMoreActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }

    fileprivate func setupView() {

        movieSearchBar.searchTextField.textColor = UIColor.white
        
        self.addRefreshingControl()
        
        controller = MovieController()
        controller?.delegate = self
        controller?.loadMovies(movieSelection: self.movieSelection ?? Constants.MovieSelection.Popular)
        
        ///Delegate and Datasource
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        ///Registering Cells
        let nibName = "MovieCollectionViewCell"
        let identifier = "MovieCell"
        movieCollectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier)
        
    }
        
    private func addRefreshingControl() {
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = #colorLiteral(red: 0.01317793038, green: 0.1344225705, blue: 0.2308762968, alpha: 1)
        self.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.movieCollectionView.addSubview(refreshControl!)
        
    }
    
    @objc func refreshList() {
        
        self.refreshControl?.endRefreshing()
        self.controller?.loadMovies(movieSelection: self.movieSelection ?? Constants.MovieSelection.Popular)
        self.movieCollectionView.reloadData()
        
    }
    
    //MARK: - GoBack
    @IBAction func tappedToGoBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - Fetch More Pages
    private func startFetchingNewPage() {
        
        fetchingMore = true
        print("beginBatchFetch!")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.loadingMoreActivityIndicator.startAnimating()
            self.controller?.loadAnotherPage()
            self.fetchingMore = false
            self.movieCollectionView.reloadData()
        })
        
    }
    
}

extension MovieViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.controller?.numberOfRows() ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setupCell(movie: (self.controller?.loadMovieWithIndexPath(indexPath: indexPath, favorite: false))!)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width / 3.4 , height: 190)//
        //return .init(width: view.frame.width / 2.2 , height: view.frame.height / 2.3)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10.0, left: 10, bottom: 20.0, right: 10)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let safeAreaTop = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        
        let magicalSafeAreaTop: CGFloat = safeAreaTop + (navigationController?.navigationBar.frame.height ?? 0)
        
        let offset = scrollView.contentOffset.y + magicalSafeAreaTop
        
        DispatchQueue.main.async {
            
            if offset > 44 {
                
                UIScrollView.animate(withDuration: 0.5) {
                    self.searchBarHight.constant = 0
                    self.movieSearchBar.transform = .init(translationX: 0, y: min(0, -offset))
                }
                
            }else {
                
                UIScrollView.animate(withDuration: 0.5) {
                    self.searchBarHight.constant = 44.00
                    self.movieSearchBar.transform = .init(translationX: 0, y: min(0, offset))
                }
                
            }
            
        }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollFrameHeight = scrollView.frame.height
        
        if offsetY > contentHeight - scrollFrameHeight * 2 { //1.5
            
            if !fetchingMore {
                startFetchingNewPage()
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Details", bundle: nil)
        
        let vc: DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewControllerID") as! DetailsViewController
        
//        let cellHero = "cellID\(indexPath.item)\(self.movieCollectionView.tag)"
//        collectionView.hero.id = cellHero
        
        vc.movie = controller?.loadMovieWithIndexPath(indexPath: indexPath)
        
        present(vc, animated: true, completion: nil)
        
    }
    
}

//MARK: - UISearchBar Delegate methods

extension MovieViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.controller?.updateArray()
                self.movieCollectionView.reloadData()
            }
            
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.controller?.updateArray()
                self.movieCollectionView.reloadData()
            }
            
        }
        else {
            
            self.controller?.searchByValue(searchText: searchText)
            
            self.movieCollectionView.reloadData()
        }
        
    }
    
}

extension MovieViewController : MovieControllerDelegate {
    
    func limitOfPagesReached() {
        
        guard noticeNoMoreData == false else { return }
        
        noticeNoMoreData = true
        
        DispatchQueue.main.async {
            
            let alerta = UIAlertController(title: "Alerta", message: "Você chegou até o final", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
            
            alerta.addAction(btnOk)
            
            self.present(alerta, animated: true)
            
        }
        
    }
    
    func successOnLoading() {
        
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
            self.loadingMoreActivityIndicator.stopAnimating()
        }
        
    }
    
    func errorOnLoading(error: Error?) {
        
        if !error!.localizedDescription.isEmpty {
            
            DispatchQueue.main.async {
                
                print("Problema ao carregar os dados de Filmes")
                
                let alerta = UIAlertController(title: "Erro", message: "Problema ao carregar os dados dos Filmes", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                
                alerta.addAction(btnOk)
                
                self.present(alerta, animated: true)
                
            }
            
        }
        
    }
    
}
