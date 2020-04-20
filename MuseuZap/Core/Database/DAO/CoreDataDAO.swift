/*
Copyright © MuseuZap. All rights reserved.

Abstract:
Data Access Object base class
Every DAO should extend this class

*/

import UIKit
import CoreData

/// Data Access Object base class
/// Every DAO should extend this class
protocol DAO {

    /// Entity Type
    associatedtype Entity: NSManagedObject

    /// Perfom a Fetch request to get all elements for a Entity Type
    /// - Returns: All objects for that Entity
    func findAll() throws -> [Entity]

//     static func fetchRequest() throws -> NSFetchRequest<Entity>
}

// MARK: - Fetch

extension DAO {

    /// Helper method to build a NSFetchRequest
    /// Entity argument matches the Entity Name of the resulting class name
    /// - Returns: Fetch Request of Result Type, is the class that represents the Request.entity
    func fetchRequest() -> NSFetchRequest<Entity> {
        let entityName = String(describing: Entity.self)
        let request: NSFetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        return request
    }

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
