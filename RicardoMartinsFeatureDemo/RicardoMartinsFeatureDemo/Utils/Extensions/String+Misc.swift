//
//  String+Misc.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 12/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation

extension String {
    enum Localizable : String {
        case app = "AppLocalizable"
        case error = "ErrorLocalizable"
        
        func getValue(code:Any) -> String {
            let key = "str-\(String(describing: self))-\(code)"
            
            let localizedString = NSLocalizedString(key, tableName: self.rawValue, comment: "")
            return localizedString == key && self != .app ? getValue(code: 0) : localizedString
        }
    }
}
