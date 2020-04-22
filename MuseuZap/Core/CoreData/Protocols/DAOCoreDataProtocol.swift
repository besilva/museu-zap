//
//  DAOCoreDataProtocol.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import CoreData

/// Core Data Data Access Object base class
protocol DAOCoreData {

    /// Entity Type
    associatedtype Entity: NSManagedObject

    /// Perfom a Fetch request to get all elements for a Entity Type
    /// - Returns: All objects for that Entity
    func findAll() throws -> [Entity]
}

// MARK: - Fetch

extension DAOCoreData {

    /// Helper method to build a NSFetchRequest
    /// Entity argument matches the Entity Name of the resulting class name
    /// - Returns: Fetch Request of Result Type, is the class that represents the Request.entity
    func fetchRequest() -> NSFetchRequest<Entity> {
        let entityName = String(describing: Entity.self)
        let request: NSFetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        return request
    }

    /// Method responsible for getting all teste from database
    /// - returns: array of teste from database
    /// - throws: if an error occurs during getting an object from database (Errors.DatabaseError)
    func findAll() throws -> [Entity] {
        // Array of objects to be returned
        var array: [Entity]

        do {
            // Creating fetch request
            let request: NSFetchRequest<Entity> = fetchRequest()

            // Perform search
            array = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(request)
        } catch {
            throw DatabaseErrors.fetch
        }

        return array
    }
}
