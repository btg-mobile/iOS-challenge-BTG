//
//  Label+Localization.swift
//  BTGTest
//
//  Created by Mario de Castro on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class LocalizedLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()

        guard let text = text else { return }
        self.text = text.localized
    }
}
