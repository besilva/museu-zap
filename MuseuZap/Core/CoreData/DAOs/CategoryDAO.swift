///
//  AudioDAO.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import CoreData
import UIKit

// MARK: - Protocol For test purpose

protocol CategoryDAOProtocol {
    // CRUD Operations: Create, Read, Update, Delete
    func create(_ objectToBeSaved: Category) throws
    func readAll() throws -> [Category]
    func updateContext() throws
    func delete(_ objectToBeDeleted: Category) throws
    func deleteAll(_ objectToBeDeleted: Category) throws
}

// MARK: - Class

/// Data Access Object for Audio Entity
class CategoryDAO: DAOCoreData, CategoryDAOProtocol {

    typealias Entity = Category
    var managedContext: NSManagedObjectContext!

    required init(intoContext context: NSManagedObjectContext) {
        self.managedContext = context
    }

    convenience init() {
        // Use the default managedObjectContext for production environment
        self.init(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
    }
}
