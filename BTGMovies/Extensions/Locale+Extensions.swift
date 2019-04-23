//
//  Locale+Extensions.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import Foundation

extension Locale {
    static var languageAndRegion: String {
        guard let language = self.preferredLanguages.first else {
            return "pt"
        }
        
        return language
    }
}
