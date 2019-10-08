//
//  Helper.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation

class Helper {
    static func removeSpecialChars(text: String) -> String {
        let replaceChars = "+-*=(),.:;\"\'!?&@#$%<>/|\\{}[]_ "
        let okayChars : Set<Character> = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890" + replaceChars)
        
        var string = String(text.filter { okayChars.contains($0) })
        
        replaceChars.forEach { c in
            string = string.replacingOccurrences(of: String(c), with: " ")
        }
        
        return string
    }
}
