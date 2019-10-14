//
//  Genre.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

struct Genre: Decodable {
    let genreId: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name = "name"
    }
}
