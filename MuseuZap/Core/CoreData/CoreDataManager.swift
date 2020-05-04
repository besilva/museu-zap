//
//  CoreDataManager.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 23/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    /// Empty initializer to avoid external instantiation
    private init() {
        
    }

    /// Database manager singleton
    static let sharedInstance = CoreDataManager()

    // MARK: - Configuration

    let moduleName = "MuseuZap"

    // The momd extension is the compiled file from xcdatamodeld
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var applicationDocumentsDirectory: NSURL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as NSURL
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        // Documents Directory + name from module. Url is created on clean launch from the app
        let persistentStoreURL = FileManager.sharedContainerURL().appendingPathComponent("\(moduleName).sqlite")

        do {
            // Options enable light weight migration (case relations change)
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: persistentStoreURL,
                                               options: [NSMigratePersistentStoresAutomaticallyOption: true,
                                                         NSInferMappingModelAutomaticallyOption: true])
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // Function fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

            fatalError("Persistent store error! \(error)")

            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.

             Check the error message to determine what the actual problem was.
             */
        }

        return coordinator
    }()
    
    // MARK: - ManagedObjectContext

    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */

    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        print("stores")
        print(self.persistentStoreCoordinator.persistentStores)
        return managedObjectContext
    }()
}
