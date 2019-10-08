//
//  TabBarItem+Localized.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class LocalizedTabBarItem: UITabBarItem {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let title = title else { return }
        self.title = title.localized
    }
}
