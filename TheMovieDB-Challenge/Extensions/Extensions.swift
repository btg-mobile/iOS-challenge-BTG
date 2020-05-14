//
//  Extensions.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 01/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func toStringWithStar() -> String {
        return "⭐️ " + String(format: "%.1f",self)
    }
}

extension UIColor {
    
    static let darkBlue = UIColor(red: 13.0, green: 37.0, blue: 63.0, alpha: 0)
    static let lightBlue = UIColor(red: 1.0, green: 180.0, blue: 228.0, alpha: 0)
    static let lightGreen = UIColor(red: 144.0, green: 206.0, blue: 161.0, alpha: 0)
    
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}

