//
//  DataManager.swift
//  TheMovieDB
//
//  Created by Usuario on 31/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    // MARK: - Core Data stack

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TheMovieDB")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
