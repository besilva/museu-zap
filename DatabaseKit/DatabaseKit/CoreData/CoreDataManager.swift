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

public class CoreDataManager {
    /// Empty initializer to avoid external instantiation
    private init() {
         
    }

    /// Database manager singleton
    public static let sharedInstance = CoreDataManager()

    // MARK: - Configuration

    let moduleName = "MuseuZap"

    // The momd extension is the compiled file from xcdatamodeld
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle(for: CoreDataManager.self).url(forResource: moduleName, withExtension: "momd")!
//            Bundle.main.url(forResource: moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var applicationDocumentsDirectory: NSURL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as NSURL
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container =  NSPersistentContainer(name: moduleName, managedObjectModel: self.managedObjectModel)
        let storeURL = FileManager.sharedContainerURL().appendingPathComponent("\(moduleName).sqlite")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (_, error) in // storeDescription, error
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // FatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - ManagedObjectContext

    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */

    public lazy var managedObjectContext: NSManagedObjectContext = {
//        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//        managedObjectContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        return self.persistentContainer.viewContext
    }()
}
