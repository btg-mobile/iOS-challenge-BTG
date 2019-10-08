//
//  UIColor+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        if let hex = UInt(hex, radix: 16) {
            self.init(r: CGFloat((hex >> 16) & 0xff), g: CGFloat((hex >> 08) & 0xff), b: CGFloat((hex >> 00) & 0xff), a: alpha)
        } else {
            self.init(r: 0, g: 0, b: 0)
        }
    }
}
