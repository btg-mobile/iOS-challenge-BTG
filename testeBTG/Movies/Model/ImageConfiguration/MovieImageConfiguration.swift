//
//  MovieImageConfiguration.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

struct MovieImageConfiguration: Decodable {
    let images: ImagesMetaData
    let changeKeys: [String]
    
    enum CodingKeys: String, CodingKey {
        case images = "images"
        case changeKeys = "change_keys"
    }
}
