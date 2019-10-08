//
//  Button+Localization.swift
//  BTGTest
//
//  Created by Mario de Castro on 08/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class LocalizedButton: UIButton {
    override func awakeFromNib() {
        if let title = title(for: .normal) {
            self.setTitle(title.localized, for: .normal)
        }
    }
}
