//
//  RealmManager.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 09/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - RealmManager
class RealmManager {

    // MARK: - Life Cycle
    class func initRealm() {
        Realm.Configuration.defaultConfiguration = migrateDatabase()
    }

    // MARK: - Database Migration
    private class func migrateDatabase() -> Realm.Configuration {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { (_, oldSchemaVersion) in

        })

        return config
    }

}
