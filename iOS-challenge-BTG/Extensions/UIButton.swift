//
//  UIButton.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 14/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(type: UIButton.ButtonType,
                     font: FontFamily = .regular,
                     withSize size: CGFloat = 12.0,
                     withTitle title: String,
                     withTitleColor titleColor: UIColor? = nil ) {
        self.init(type: type)
        self.setTitleForAllStates(title)
        if let titleColor = titleColor {
            self.setTitleColorForAllStates(titleColor)
        }
        switch font {
        case .italic:
            self.titleLabel?.font = UIFont.italicSystemFont(ofSize: size)
        case .regular:
            self.titleLabel?.font = UIFont.systemFont(ofSize: size)
        case .bold:
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: size)
        }
    }
    
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
    
    public func setImageForAllStates(_ image: UIImage) {
        states.forEach { setImage(image, for: $0) }
    }
    
    public func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { setTitleColor(color, for: $0) }
    }
    
    public func setTitleForAllStates(_ title: String) {
        states.forEach { setTitle(title, for: $0) }
    }
}
