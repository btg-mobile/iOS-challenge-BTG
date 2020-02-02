//
//  Extensions.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 01/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

extension Double {
    func toStringWithStar() -> String {
        return "⭐️ " + String(format: "%.1f",self)
    }
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
