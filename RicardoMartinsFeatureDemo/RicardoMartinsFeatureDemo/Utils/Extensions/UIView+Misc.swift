//
//  UIView+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

extension UIView{
    convenience init(frame:CGRect = .zero, backgroundColor color: UIColor? = nil, height:CGFloat? = nil) {
        self.init(frame: frame)
        backgroundColor = color
        anchor(height: height)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setShadow(color: UIColor = .black, offset: CGSize = .zero, radius: CGFloat = 0, opacity: Float = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}

extension UIView {
    @discardableResult
    func anchor(centerX: (anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                centerY: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                top: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                left: (anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                right: (anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                bottom: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil) -> AnchoredConstraint {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredConstraint = AnchoredConstraint()
        
        if let centerX = centerX { anchoredConstraint.centerX = centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.padding) }
        if let centerY = centerY { anchoredConstraint.centerY = centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.padding) }
        if let top = top { anchoredConstraint.top = topAnchor.constraint(equalTo: top.anchor, constant: top.padding) }
        if let left = left { anchoredConstraint.left = leftAnchor.constraint(equalTo: left.anchor, constant: left.padding) }
        if let right = right { anchoredConstraint.right = rightAnchor.constraint(equalTo: right.anchor, constant: -right.padding) }
        if let bottom = bottom { anchoredConstraint.bottom = bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.padding) }
        if let width = width { anchoredConstraint.width = widthAnchor.constraint(equalToConstant: width) }
        if let height = height { anchoredConstraint.height = heightAnchor.constraint(equalToConstant: height) }
        
        [anchoredConstraint.centerX, anchoredConstraint.centerY, anchoredConstraint.top, anchoredConstraint.left, anchoredConstraint.right, anchoredConstraint.bottom, anchoredConstraint.width, anchoredConstraint.height].forEach { $0?.isActive = true }
        
        return anchoredConstraint
    }
    
    @discardableResult
    func anchorFillSuperView(padding: UIEdgeInsets = .zero, topSafeArea: Bool = true, bottomSafeArea: Bool = false) -> AnchoredConstraint {
        var anchoredConstraint = AnchoredConstraint()
        if let superview = superview {
            anchoredConstraint = anchor (
                top: ( topSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor, padding.top),
                left: (superview.leftAnchor, padding.left),
                right: (superview.rightAnchor, padding.right),
                bottom: ( bottomSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor, padding.bottom)
            )
        }
        return anchoredConstraint
    }
    
    @discardableResult
    func anchorFillSuperView(padding: CGFloat, topSafeArea: Bool = true, bottomSafeArea: Bool = false) -> AnchoredConstraint {
        var anchoredConstraint = AnchoredConstraint()
        if let superview = superview {
            anchoredConstraint = anchor (
                top: ( topSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor, padding),
                left: (superview.leftAnchor, padding),
                right: (superview.rightAnchor, padding),
                bottom: ( bottomSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor, padding)
            )
        }
        return anchoredConstraint
    }
}

struct AnchoredConstraint {
    var centerX, centerY, top, left, right, bottom, width, height: NSLayoutConstraint?
}
