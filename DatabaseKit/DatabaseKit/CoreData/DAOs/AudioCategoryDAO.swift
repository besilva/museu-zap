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

public protocol AudioCategoryDAOProtocol {
    // CRUD Operations: Create, Read, Update, Delete
    func create(_ objectToBeSaved: AudioCategory) throws
    func readAll() throws -> [AudioCategory]
    func updateContext() throws
    func delete(_ objectToBeDeleted: AudioCategory) throws
    func deleteAll(_ objectToBeDeleted: AudioCategory) throws
}

// MARK: - Class

/// Data Access Object for Audio Entity
public class AudioCategoryDAO: DAOCoreData, AudioCategoryDAOProtocol {
    
    public typealias Entity = AudioCategory
    public var managedContext: NSManagedObjectContext!

    required public init(intoContext context: NSManagedObjectContext) {
        self.managedContext = context
    }

    public convenience init() {
        // Use the default managedObjectContext for production environment
        self.init(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
    }
}
