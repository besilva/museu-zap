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
public protocol DAOCoreData {

    /// Adopted managedObjectContext from persistentContainer.
    /// The managedContext uses models from MuseuZap.xcdatamodeld BUT can be stored in the device or RAM memory (for tests).
    var managedContext: NSManagedObjectContext! { get }
    init(intoContext: NSManagedObjectContext)

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
    public func create(_ objectToBeSaved: Entity) throws {
        do {
            // Persist changes at the context.
            // When entity is created, it automatically insert it into shared context.
            try managedContext.save()
        } catch {
            print("DATABASE ERROR CREATE \n", error)
            throw DatabaseErrors.create
        }
    }

    // MARK: - Read

    /// Method responsible for getting all Entities from CoreData
    /// - returns: Array of Enity from database
    /// - throws: If an error occurs during getting an object from CoreData (DatabaseErrors.read)
    public func readAll() throws -> [Entity] {
        // Array of objects to be returned
        var array: [Entity]
        do {
            // Creating fetch request
            let request: NSFetchRequest<Entity> = fetchRequest()
            // Perform search
            array = try managedContext.fetch(request)
        } catch {
            print("DATABASE ERROR READ \n", error)
            throw DatabaseErrors.read
        }
        return array
    }
    
    // MARK: - Update

    /// Method responsible for updating an Entity into CoreData
    /// - parameters:
    ///     - objectToBeUpdated: Entity to be updated on CoreData
    /// - throws: If an error occurs during updating an object into CoreData (DatabaseErrors.update)
    public func updateContext() throws {
        do {
            // Persist changes at the context
            try managedContext.save()
        } catch {
            print("DATABASE ERROR UPDATE \n", error)
            throw DatabaseErrors.update
        }
    }

    // MARK: - Delete

    /// Method responsible for deleting an Entity from CoreData
    /// - parameters:
    ///     - objectToBeSaved: Entity to be saved on CoreData
    /// - throws: If an error occurs during deleting an object into CoreData (DatabaseErrors.delete)
    public func delete(_ objectToBeDeleted: Entity) throws {
        do {
            // Delete element from context
            managedContext.delete(objectToBeDeleted)

            // Persist the operation
            try managedContext.save()
        } catch {
            print("DATABASE ERROR DELETE \n", error)
            throw DatabaseErrors.delete
        }
    }

    public func deleteAll(_ objectToBeDeleted: Entity) throws {
        // Creating fetch request
        let request: NSFetchRequest<Entity> = fetchRequest()

        do {
            let objs = try managedContext.fetch(request)

            for case let obj as NSManagedObject in objs {
                managedContext.delete(obj)
            }
        } catch {
            print("DATABASE ERROR DELETE \n", error)
            throw DatabaseErrors.delete
        }

        do {
            // Persist changes at the context
            try managedContext.save()
        } catch {
            print("DATABASE ERROR UPDATE in delete \n", error)
            throw DatabaseErrors.update
        }
    }

    // MARK: - Helper

    /// Helper method to build a NSFetchRequest
    /// Entity argument matches the Entity Name of the resulting class name
    /// - Returns: Fetch Request of Result Type, is the class that represents the Request.entity
    public func fetchRequest() -> NSFetchRequest<Entity> {
        let entityName = String(describing: Entity.self)
        let request: NSFetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        return request
    }
}
