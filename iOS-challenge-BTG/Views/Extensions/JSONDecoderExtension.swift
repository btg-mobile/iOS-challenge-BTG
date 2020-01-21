//
//  JSONDecoderExtension.swift
//  iOS-challenge-BTG
//
//  Created by Bruno on 20/01/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func setCustomDateDecodingStrategy() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateDecodingStrategy = .formatted(formatter)
    }
}
