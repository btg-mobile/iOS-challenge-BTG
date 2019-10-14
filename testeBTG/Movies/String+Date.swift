//
//  String+Date.swift
//  testeBTG
//
//  Created by pc on 14/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

extension String {
    func formatDate() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: self)
        inputFormatter.dateFormat = "MM/dd/yyyy"
        if let showDate = showDate {
            let resultString = inputFormatter.string(from: showDate)
            return resultString
        }else {
            return nil
        }
    }
}
