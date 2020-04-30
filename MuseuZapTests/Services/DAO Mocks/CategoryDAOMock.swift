//
//  CategoryDAOMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.

@testable import MuseuZap
import CoreData

/// Mocked Category DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
class CategoryDAOMock: CategoryDAOProtocol {

    var shouldThrowError: Bool = false

    var coreDataHelper = CoreDataTestHelper()

    func create(_ objectToBeSaved: MuseuZap.Category) throws {
        if shouldThrowError {
            throw DatabaseErrors.create
        }
    }

    func readAll() throws -> [MuseuZap.Category] {
        if shouldThrowError {
            throw DatabaseErrors.read
        } else {
            let category = Category(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
            category.categoryName = "readAll"
            return [category]
        }
    }

    func fetchWithPredicate(predicate: NSPredicate) throws -> [MuseuZap.Category] {
        if shouldThrowError {
            throw DatabaseErrors.publicAndPrivate
        } else {
            let category = Category(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
            return [category]
        }
    }

    func updateContext() throws {
        if shouldThrowError {
              throw DatabaseErrors.update
        }
    }

    func delete(_ objectToBeDeleted: MuseuZap.Category) throws {
        if shouldThrowError {
            throw DatabaseErrors.delete
        }
    }

    func deleteAll(_ objectToBeDeleted: MuseuZap.Category) throws {
        if shouldThrowError {
            throw DatabaseErrors.delete
        }
    }
}
