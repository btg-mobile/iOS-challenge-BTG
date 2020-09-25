//
//  Extensions.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 01/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit
import Lottie

//MARK: - Double
extension Double {
    func toStringWithStar() -> String {
        return "⭐️ " + String(format: "%.1f",self)
    }
}

//MARK: - UIColor
extension UIColor {
    
    static let darkBlue:  UIColor = #colorLiteral(red: 0.01234783977, green: 0.1457155645, blue: 0.254773736, alpha: 1)
    static let lightBlue:  UIColor = #colorLiteral(red: 0.02253310941, green: 0.7065569758, blue: 0.8912119269, alpha: 1)
    static let lightGreen: UIColor = #colorLiteral(red: 0.5648525357, green: 0.8052322268, blue: 0.6340113282, alpha: 1)
    
}

//MARK: - String
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
}

//MARK: - UserDefaults
extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func isFirstUse() -> Bool {
        
        return bool(forKey: "isFirstUse")
        
    }
    
    func setFirstUse(_ value: Bool) {
        set(value, forKey: "isFirstUse")
        synchronize()
    }
}

//MARK: - UIView
extension UIView {
    
    func anchorToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsToTop(top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        
        _ = anchor(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }

}

//MARK: - Lottie
extension UIViewController {

    public enum animationFile : String {
        case movieLoading1 = "1961-movie-loading"
        case movieLoading2 = "19404-video-playback"
        case movieLoading3 = "19117-movie-clapperboard"
    }
    
    public func lottieStartAnimation(on uiview: AnimationView, animationFileName: animationFile) {
        
        let animation = Animation.named(animationFileName.rawValue)
        uiview.animation = animation
        uiview.loopMode = .loop
        uiview.play()
        
    }
    
    public func lottieStopAnimation(on uiview: AnimationView) {
        
        uiview.stop()
        uiview.animation = nil
        
    }
    
}

//MARK: - Notification
extension Notification.Name {
    
    static let loginCancelled = Notification.Name("cancelLoginObserver")
    
}
