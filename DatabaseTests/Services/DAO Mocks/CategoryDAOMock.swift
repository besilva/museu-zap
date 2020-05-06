//
//  CategoryDAOMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.

@testable import Database
import CoreData

/// Mocked Category DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
class CategoryDAOMock: AudioCategoryDAOProtocol {
    
    var shouldThrowError: Bool = false

    var coreDataHelper = CoreDataTestHelper()

    func create(_ objectToBeSaved: Database.AudioCategory) throws {
        if shouldThrowError {
            throw DatabaseErrors.create
        }
    }

    func readAll() throws -> [Database.AudioCategory] {
        if shouldThrowError {
            throw DatabaseErrors.read
        } else {
            let category = AudioCategory(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
            category.categoryName = "readAll"
            return [category]
        }
    }

    func fetchWithPredicate(predicate: NSPredicate) throws -> [Database.AudioCategory] {
        if shouldThrowError {
            throw DatabaseErrors.publicAndPrivate
        } else {
            let category = AudioCategory(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
            return [category]
        }
    }

    func updateContext() throws {
        if shouldThrowError {
              throw DatabaseErrors.update
        }
    }

    func delete(_ objectToBeDeleted: Database.AudioCategory) throws {
        if shouldThrowError {
            throw DatabaseErrors.delete
        }
    }

    func deleteAll(_ objectToBeDeleted: Database.AudioCategory) throws {
        if shouldThrowError {
            throw DatabaseErrors.delete
        }
    }
}
