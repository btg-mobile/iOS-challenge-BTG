//
//  GenreResponse.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/23/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import Foundation
import ObjectMapper

struct genreResponse : Mappable {
    var genres : [Genre]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        genres <- map["genres"]
    }

}
