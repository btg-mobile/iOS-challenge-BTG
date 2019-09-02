//
//  BackCardItemType.swift
//  TMDb
//
//  Created by Renato De Souza Machado Filho on 04/08/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

enum BackCardItemType {
    case introduction(name: String?, description: String?)
    case genres([Genre])
}
