//
//  OnbordViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 11/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class OnbordingViewController: UIViewController {
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var constraintPageControl: NSLayoutConstraint!
    @IBOutlet weak var constraintSkipButton: NSLayoutConstraint!
    @IBOutlet weak var constraintNextButton: NSLayoutConstraint!
    
    private var viewModel = OnboardingViewModel()
    private var cancelLoginObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        registerCells()
        setupNotificationObserver()
        
    }
    
    deinit {
        
        if let cancelLogin = cancelLoginObserver {
            NotificationCenter.default.removeObserver(cancelLogin)
        }
        
    }
    
    private func setupNotificationObserver() {
        
        cancelLoginObserver = NotificationCenter.default.addObserver(forName: .loginCancelled, object: nil, queue: .main) { [weak self] ( _ ) in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    private func setupView() {
        
        pageControl.numberOfPages = self.viewModel.getNumberOfItems() + 1
        
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.isPagingEnabled = true
        onboardingCollectionView.frame = .zero
        
    }
    
    private func registerCells() {
        
        onboardingCollectionView.register(UINib(nibName: "OnboardingViewCell", bundle: nil), forCellWithReuseIdentifier: "onboardingViewCell")
        onboardingCollectionView.register(UINib(nibName: "LoginCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoginCollectionViewCellIdentifier")
        
    }
    
    @IBAction func tappedSkip(_ sender: UIButton) {
        
        pageControl.currentPage = self.viewModel.getNumberOfItems() - 1
        nextPage()
        
    }
    
    @IBAction func tappedNext(_ sender: UIButton) {
        
        nextPage()
        
    }
    
    private func nextPage() {
        
        if pageControl.currentPage == self.viewModel.getNumberOfItems() {
            return
        }
        
        if pageControl.currentPage == self.viewModel.getNumberOfItems() - 1 {
            moveControlConstraintsOffScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        constraintPageControl.constant = -80
        constraintSkipButton.constant = -80
        constraintNextButton.constant = -80
    }
    
    fileprivate func moveControlConstraintsOnScreen() {
        constraintPageControl.constant = 25
        constraintSkipButton.constant = 10
        constraintNextButton.constant = 10
    }
    
}

//MARK: - Extension For CollectionView Delegate, DataSource and Layout
extension OnbordingViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfItems() + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == self.viewModel.getNumberOfItems() {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoginCollectionViewCellIdentifier", for: indexPath) as! LoginCollectionViewCell
            
            cell.delegate = self
            
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingViewCell", for: indexPath) as! OnboardingViewCell
            cell.page = self.viewModel.getPageWithIndex(for: indexPath)
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width , height: view.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        onboardingCollectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        DispatchQueue.main.async {
            
            self.onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            self.onboardingCollectionView.reloadData()
            
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == self.viewModel.getNumberOfItems() {
            
            moveControlConstraintsOffScreen()
            
        }else {
            
            moveControlConstraintsOnScreen()
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
}

extension OnbordingViewController : LoginCollectionViewCellDelegate {
    
    //From Login Cell
    func openLogin() {
        
        let loginView = LoginRouter.createModule(as: .fullScreen)
        
        self.present(loginView, animated: true)
    
    }
    
    func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
