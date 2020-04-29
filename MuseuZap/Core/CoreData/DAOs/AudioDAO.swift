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

    // MARK: - AUDIO only

    /// Method responsible for getting all Private Audios from CoreData
    /// - returns: Array of private Audios
    /// - throws: If an error occurs during getting an object from CoreData (DatabaseErrors.read)
    func getAllPrivateAudios() throws -> [Entity] {
        // Array of objects to be returned
        var privateAudios: [Entity]
        do {
            // Creating fetch request
            let request: NSFetchRequest<Entity> = fetchRequest()
            // Predicate for isPrivate property
            // Fetch the ones that isPrivate property == true
            request.predicate = NSPredicate(format: "isPrivate == true")

            privateAudios = try managedContext.fetch(request)
        } catch {
            print("DATABASE ERROR READ \n", error)
            throw DatabaseErrors.read
        }
        return privateAudios
    }

    /// Method responsible for getting all the public Audios from CoreData
    /// - returns: Array of public Audios
    /// - throws: If an error occurs during getting an object from CoreData (DatabaseErrors.read)
    func getPublicAudios() throws -> [Entity] {
        // Array of objects to be returned
        var publicAudios: [Entity]
        do {
            // Creating fetch request
            let request: NSFetchRequest<Entity> = fetchRequest()
            // Predicate for isPrivate property
            // Fetch the ones that isPrivate property == true
            request.predicate = NSPredicate(format: "isPrivate == false")

            publicAudios = try managedContext.fetch(request)
        } catch {
            print("DATABASE ERROR READ \n", error)
            throw DatabaseErrors.read
        }
        return publicAudios
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

    func getPublicAudios() throws -> [Audio]
    func getAllPrivateAudios() throws -> [Audio]
}
