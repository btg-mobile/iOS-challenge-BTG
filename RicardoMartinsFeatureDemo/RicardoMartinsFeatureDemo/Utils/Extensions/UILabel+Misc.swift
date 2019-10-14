//
//  UILabel+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 12/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String?, font: UIFont?){
        self.init()
        self.text = text
        self.font = font
    }
}
