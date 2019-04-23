//
//  BaseViewController.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Enums
    
    enum ControllerState {
        case loading
        case pullToRefresh
        case error
        case empty
        case `default`
    }
    
    enum ControllerFlow {
        case modal(createNavigation: Bool)
        case push
        case automatic
    }
    
    // MARK: - Constants
    
    var isFromNavigation = true
    var viewState: ControllerState = .default
    
    // MARK: - Init
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instantiate
    
    func open(flow: ControllerFlow = .automatic) {
        let topController = UIApplication.topViewController()
        
        func push(from: UIViewController?) {
            self.isFromNavigation = true
            let navigation = topController as? UINavigationController ?? topController?.navigationController
            navigation?.pushViewController(self, animated: true)
        }
        
        func present(from: UIViewController?, createNavigation: Bool) {
            self.isFromNavigation = false
            if createNavigation {
                let navigation = UINavigationController(rootViewController: self)
                topController?.present(navigation, animated: true)
            } else {
                topController?.present(self, animated: true)
            }
        }
        
        switch flow {
        case .modal(let createNavigation):
            present(from: topController, createNavigation: createNavigation)
        case .push:
            push(from: topController)
        case .automatic:
            if topController as? UINavigationController != nil || topController?.navigationController != nil {
                push(from: topController)
            } else {
                self.isFromNavigation = false
                present(from: topController, createNavigation: true)
            }
        }
    }
    
    func close() {
        if isFromNavigation {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func addTapToEndEditing() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func tapOnView() {
        self.view.endEditing(true)
    }
}
