//
//  AudioDAO.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import CoreData
import UIKit

// TODO; return by id
// todo return by private

/// Data Access Object for Audio Entity
class AudioDAO: DAOCoreData, AudioDAOProtocol {

    typealias Entity = Audio
    var managedContext: NSManagedObjectContext!

    required init(intoContext context: NSManagedObjectContext) {
        self.managedContext = context
    }

    convenience init() {
        // Use the default managedObjectContext for production environment
        self.init(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
    }
}

// MARK: - For test purpose

protocol AudioDAOProtocol {
    // CRUD Operations: Create, Read, Update, Delete
    func create(_ objectToBeSaved: Audio) throws
    func readAll() throws -> [Audio]
    func updateContext() throws
    func delete(_ objectToBeDeleted: Audio) throws
    func deleteAll(_ objectToBeDeleted: Audio) throws
}
