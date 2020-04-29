//
//  AudioDAO.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import CoreData
import UIKit

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

    // MARK: - AUDIO ONLY

    /// Method responsible for getting a custom set of Entities, returns private or public audios depending on argument
    /// - returns: Result from the custom search from Entities, private (bool = true) and public (bool = false)
    /// - throws: If an error occurs during getting an object from CoreData (DatabaseErrors.fetchPredicate)
    func fetchAudiosWith(isPrivate: Bool) throws -> [Entity] {
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

// MARK: - For test purpose

protocol AudioDAOProtocol {
    // CRUD Operations: Create, Read, Update, Delete
    func create(_ objectToBeSaved: Audio) throws
    func readAll() throws -> [Audio]
    func fetchAudiosWith(isPrivate: Bool) throws -> [Audio]
    func updateContext() throws
    func delete(_ objectToBeDeleted: Audio) throws
    func deleteAll(_ objectToBeDeleted: Audio) throws
}
