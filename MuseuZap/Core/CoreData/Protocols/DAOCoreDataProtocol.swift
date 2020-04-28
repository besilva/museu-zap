//
//  DAOCoreDataProtocol.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Protocol

/// Core Data Data Access Object base class
/// Protocol Oriented
protocol DAOCoreData: class {

    /// Adopted persistentContainer.
    /// The container uses models from MuseuZap.xcdatamodeld BUT can be stored in the device or RAM memory (for tests).
    var container: NSPersistentContainer! { get }
    init(container: NSPersistentContainer)

    /// Entity Type for current DAO
    associatedtype Entity: NSManagedObject

    // CRUD Operations: Create, Read, Update, Delete
    func create(_ objectToBeSaved: Entity) throws
    func readAll() throws -> [Entity]
    func updateContext() throws
    func delete(_ objectToBeDeleted: Entity) throws
    func deleteAll(_ objectToBeDeleted: Entity) throws
}

// MARK: - Implementations

extension DAOCoreData {

    // MARK: - Create

    /// Method responsible for saving an Entity into CoreData
    /// - parameters:
    ///     - objectToBeSaved: Entity to be saved on database
    /// - throws: If an error occurs during saving an object into database (DatabaseErrors.create)
    func create(_ objectToBeSaved: Entity) throws {
        do {
            // Add object to be saved to the context
            container.viewContext.insert(objectToBeSaved)

            // Aersist changes at the context
            try container.viewContext.save()
        } catch {
            throw error // TODO: how to through the error message?
        }
    }

    // MARK: - Read

    /// Method responsible for getting all Entities from CoreData
    /// - returns: Array of Enity from database
    /// - throws: If an error occurs during getting an object from CoreData (DatabaseErrors.read)
    func readAll() throws -> [Entity] {
        // Array of objects to be returned
        var array: [Entity]
        do {
            // Creating fetch request
            let request: NSFetchRequest<Entity> = fetchRequest()
            // Perform search
            array = try container.viewContext.fetch(request)
        } catch {
            throw DatabaseErrors.read
        }
        return array
    }

    // MARK: - Update

    // TODO: read about fetch request predicate
    // PRECISAREI pra fazer o método de retornar apenas audios publicos e privados

    /// Method responsible for updating an Entity into CoreData
    /// - parameters:
    ///     - objectToBeUpdated: Entity to be updated on CoreData
    /// - throws: If an error occurs during updating an object into CoreData (DatabaseErrors.update)
    func updateContext() throws {
        do {
            // Persist changes at the context
            try container.viewContext.save()
        } catch {
            throw DatabaseErrors.update
        }
    }

    // MARK: - Delete

    /// Method responsible for deleting an Entity from CoreData
    /// - parameters:
    ///     - objectToBeSaved: Entity to be saved on CoreData
    /// - throws: If an error occurs during deleting an object into CoreData (DatabaseErrors.delete)
    func delete(_ objectToBeDeleted: Entity) throws {
        do {
            // Delete element from context
            container.viewContext.delete(objectToBeDeleted)

            // Persist the operation
            try container.viewContext.save()
        } catch {
            throw DatabaseErrors.delete
        }
    }

    func deleteAll(_ objectToBeDeleted: Entity) throws {
        // Creating fetch request
        let request: NSFetchRequest<Entity> = fetchRequest()

        // swiftlint:disable force_try
        let objs = try! container.viewContext.fetch(request)

        for case let obj as NSManagedObject in objs {
            container.viewContext.delete(obj)
        }

        try! container.viewContext.save()
        // swiftlint:enable force_try
    }

    // MARK: - Helper

    /// Helper method to build a NSFetchRequest
    /// Entity argument matches the Entity Name of the resulting class name
    /// - Returns: Fetch Request of Result Type, is the class that represents the Request.entity
    func fetchRequest() -> NSFetchRequest<Entity> {
        let entityName = String(describing: Entity.self)
        let request: NSFetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        return request
    }
}
