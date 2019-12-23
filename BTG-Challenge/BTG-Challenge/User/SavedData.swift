//
//  SavedData.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/23/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import Foundation


class UserData {
    static let sharedInstance = UserData()
    var favorites : [Results] = []
    
    private init() {
        
    }
}
