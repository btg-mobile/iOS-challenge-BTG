//
//  AlertButton.swift
//  PrettyAlert
//
//  Created by Алексей Пархоменко on 08/04/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

@IBDesignable
class AlertButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 22
    }

}
