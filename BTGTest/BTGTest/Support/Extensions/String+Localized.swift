//
//  String+Localized.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

// MARK: - Localize String
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
