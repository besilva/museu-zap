//
//  AudioServicesTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap
import CoreData

    // MARK: - Category Services

class CategoryServicesTests: XCTestCase {

    var sut: CategoryServices!
    /// In order to create Category Entities
    var coreDataHelper: CoreDataTestHelper!
    /// Mocked Audio DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
    let categoryDAO = CategoryDAOMock()

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        sut = CategoryServices(dao: categoryDAO)
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        // Audio should be flushed first because category cannot be nil
        coreDataHelper.flushData(from: "Audio")
        coreDataHelper.flushData(from: "Category")
        coreDataHelper = nil
    }

    // MARK: - Create

    // Mock DAO does nothing, should not produce errors
    func testCreate() {
        categoryDAO.shouldThrowError = false

        let category = Category(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "create"

        sut.createCategory(category: category) { (error) in
            print("Services create error", error as Any)
            XCTFail("Closure should not be invoked")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testCreateError() {
        categoryDAO.shouldThrowError = true

        let category = Category(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "createError"

        sut.createCategory(category: category) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.create)
        }
    }

    // MARK: - Read

    func testGetAllCategories() {
        categoryDAO.shouldThrowError = false

        // Category Array should contain exactly one record
        sut.getAllCategories { (error, categoryArray) in
            XCTAssertEqual(categoryArray?.count, 1, "AudioDAO Mock read func creates only 1 item not \(categoryArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
        }
    }

    func testGetAllCategoriesError() {
        categoryDAO.shouldThrowError = true

        sut.getAllCategories({ (error, categoryArray) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.read)
            XCTAssertNil(categoryArray, "Array should be nil")
        })
    }
    // MARK: - Update

    // Mock DAO does nothing, should not produce errors
    func testUpdateAllCategories() {
        categoryDAO.shouldThrowError = false

        sut.updateAllCategories { (error) in
           print("Services update error", error as Any)
           XCTFail("Closure should not be invoked")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testUpdateAllCategoriesError() {
        categoryDAO.shouldThrowError = true

        sut.updateAllCategories { (error) in
           // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.update)
        }
    }

    // MARK: - Delete

    // Mock DAO does nothing, should not produce errors
    func testDelete() {
        categoryDAO.shouldThrowError = false

        let category = Category(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "deleteError"

        sut.deleteCategory(category: category) { (error) in
            print("Services update error", error as Any)
            XCTFail("Closure should not be invoked")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testDeleteErrors() {
        categoryDAO.shouldThrowError = true

        let category = Category(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "deleteError"

        sut.deleteCategory(category: category) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.delete)
        }
    }
}

// MARK: - DAO mocks

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
