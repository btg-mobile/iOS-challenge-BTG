//
//  UILabel.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 14/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

public enum FontFamily {
    case italic
    case regular
    case bold
}

extension UILabel {
    convenience init(font: FontFamily = .regular,
                     withSize size: CGFloat = 16.0,
                     withColor textColor: UIColor = .darkGray,
                     withText text: String? = nil,
                     withTextAlignment textAlignment: NSTextAlignment = .natural,
                     withLines numberLines: Int = 1) {
        self.init()
        self.textColor = textColor
        self.numberOfLines = numberLines
        self.text = text
        self.textAlignment = textAlignment
        switch font {
        case .italic:
            self.font = UIFont.italicSystemFont(ofSize: size)
        case .regular:
            self.font = UIFont.systemFont(ofSize: size)
        case .bold:
            self.font = UIFont.boldSystemFont(ofSize: size)
        }
    }
}
