//
//  DateTransform.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import ObjectMapper

class DateTransform: TransformType {

    open func transformFromJSON(_ value: Any?) -> Date? {
        guard let dateString = value as? String,
            let date = dateString.asDate else {
            return nil
        }

        return date
    }

    open func transformToJSON(_ value: Date?) -> Double? {
        return nil
    }
}
