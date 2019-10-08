//
//  UserDefaultsService.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation

class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private init(){}
    
    func encode(obj:Any, key:String){
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: obj, requiringSecureCoding: false){
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func decode<T:Any>(key:String) throws -> T{
        guard let data = UserDefaults.standard.data(forKey: key) else { throw NSError() }
        guard let obj = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T else { throw NSError() }
        return obj
    }
    
    func remove(key:String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}
