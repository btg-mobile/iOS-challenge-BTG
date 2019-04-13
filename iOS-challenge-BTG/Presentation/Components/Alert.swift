//
//  Alert.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 13/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

enum AlertMode {
    case success
    case error
    case warning
}

public class Alert: NSObject {
    
    public static let shared = Alert()
    
    private let alertTag = 1000
    private let defaultMargin: CGFloat = 12
    
    private lazy var mainWindow: UIWindow? = {
        return UIApplication.shared.keyWindow
    }()
    
    private lazy var screenSize: CGRect = {
        return UIScreen.main.bounds
    }()
    
    private lazy var frame: CGRect = {
        let height = self.screenSize.height * 0.15
        return CGRect(x: 0, y: -(height), width: screenSize.width, height: height)
    }()
    
    private lazy var alertView: UIView = {
        let view = UIView(frame: self.frame)
        view.tag = alertTag
        return view
    }()
    
    private lazy var label: UILabel = {
        frame.size.width = frame.width - 32
        frame.size.height = frame.height - 32
        let label = UILabel(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.textAlignment = .center
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private override init() {}
    
    func showMessage(message: String, mode: AlertMode = .error) {
        if let window = mainWindow {
            guard window.viewWithTag(alertTag) == nil else { return }
            
            switch mode {
            case .success:
                alertView.backgroundColor = UIColor.green
            case .error:
                alertView.backgroundColor = UIColor.orange
            case .warning:
                alertView.backgroundColor = UIColor.yellow
            }
            
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.text = message
            
            alertView.addSubview(label)
            window.addSubview(alertView)
            
            label.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: defaultMargin).isActive = true
            label.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -defaultMargin).isActive = true
            label.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -(defaultMargin + 8) ).isActive = true
            
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.alertView.frame.origin.y = 0
            }
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(removeAlertView), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func removeAlertView() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alertView.frame.origin.y = -(self?.frame.height ?? 0)
            }, completion: { [weak self] _ in
                self?.removeView(tag: self?.alertTag ?? 1000)
        })
    }
    
    private func removeView(tag: Int) {
        findView(by: tag)?.removeFromSuperview()
    }
    
    private func findView(by tag: Int) -> UIView? {
        if let window = mainWindow {
            guard let view = window.viewWithTag(tag) else {
                return nil
            }
            return view
        }
        return nil
    }
    
}
