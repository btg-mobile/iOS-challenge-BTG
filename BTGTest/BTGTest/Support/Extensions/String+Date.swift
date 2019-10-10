//
//  String+Date.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

extension String {

    var asDate: Date? {
        let format = "yyyy-MM-dd"
        let locale = Locale.current.languageCode ?? "pt"

        let formatter = DateFormatter(
            withFormat: format,
            locale: locale)
        return formatter.date(from: self)
    }
}
