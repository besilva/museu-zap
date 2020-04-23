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

    var container: NSPersistentContainer! { get }

    init(container: NSPersistentContainer)

    /// Perfom a Fetch request to get all elements for a Entity Type
    /// - Returns: All objects for that Entity
    func findAll() throws -> [Entity]

    func save(_ objectToBeSaved: Entity) throws
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
            array = try container.viewContext.fetch(request)
        } catch {
            throw DatabaseErrors.fetch
        }
        return array
    }

    /// Method responsible for saving a season into database
    /// - parameters:
    ///     - objectToBeSaved: season to be saved on database
    /// - throws: if an error occurs during saving an object into database (Errors.DatabaseFailure)
    func save(_ objectToBeSaved: Entity) throws {
        do {
            // Add object to be saved to the context
            container.viewContext.insert(objectToBeSaved)

            // Aersist changes at the context
            try container.viewContext.save()
        } catch {
            throw DatabaseErrors.fetch
        }
    }
}
