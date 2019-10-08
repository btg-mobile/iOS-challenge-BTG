//
//  URLPath.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

// MARK: - URLPath
struct URLPath {

    enum BaseURLType: String {
        case movieDB = "MOVIEDB_BASE_URL"
        case movieDBImage = "MOVIEDBIMAGE_BASE_URL"
    }

    enum ImageSize: String {
        case small = "/w92"
        case large = "/w500"
        case backdrop = "/w780"
    }

    // MARK: - Paramethers
    let baseURLType: BaseURLType
    let path: String

    // MARK: - Private Paramethers
    private var baseUrl: String {
        return Bundle.infoDictionaryValue(forKey: baseURLType.rawValue)
    }

    // MARK: - Path Constructor
    var fullPath: String {
        return self.baseUrl+path
    }

    func imagePath(forSize size: ImageSize) -> String {
        let sizePath = size.rawValue
        return self.baseUrl+sizePath+path
    }
}
