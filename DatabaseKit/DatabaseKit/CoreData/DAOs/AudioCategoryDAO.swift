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
    func fetchCategoriesWith(isPrivate: Bool) throws -> [AudioCategory]
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
    
    public func fetchCategoriesWith(isPrivate: Bool) throws -> [AudioCategory] {
        // Array of objects to be returned
        var audios: [Entity]

        // Custom search predicate: depending on argument
        // Returns all audios with isPrivate == true or all audios with isPrivate == false
       let predicate: NSPredicate = isPrivate ? NSPredicate(format: "isPrivate == true") : NSPredicate(format: "isPrivate == false")

        do {
            // Creating fetch request
            let request: NSFetchRequest<Entity> = fetchRequest()

            // Fetch the ones according to the predicate
            request.predicate = predicate

            audios = try managedContext.fetch(request)
        } catch {
            print("DATABASE ERROR PUBLIC PRIVATE \n", error)
            throw DatabaseErrors.publicAndPrivate
        }
        return audios
    }
}
