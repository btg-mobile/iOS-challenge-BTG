//
//  Bundle+Info.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

// MARK: - InfoDictionary Value
extension Bundle {
    static func infoDictionaryValue(forKey key: String) -> String {
        if let dictionary = self.main.infoDictionary, let value = dictionary[key] as? String {
            return value
        }
        return ""
    }
}
