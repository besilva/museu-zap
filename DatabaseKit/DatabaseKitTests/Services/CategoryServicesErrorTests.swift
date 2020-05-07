//
//  CategoryServicesErrorTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import DatabaseKit
import CoreData

    // MARK: - Category Services

class CategoryServicesErrorTests: XCTestCase {

    var sut: AudioCategoryServices!
    /// In order to create Category Entities
    var coreDataHelper: CoreDataTestHelper!
    /// Mocked Audio DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
    var categoryDAO: CategoryDAOMock!

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        categoryDAO = CategoryDAOMock()
        sut = AudioCategoryServices(dao: categoryDAO)

        // Category Services Error, therefore
        categoryDAO.shouldThrowError = true
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        // Audio should be flushed first because category cannot be nil
        coreDataHelper.flushData(from: "Audio")
        coreDataHelper.flushData(from: "AudioCategory")
        coreDataHelper = nil

        categoryDAO = nil
    }

    // MARK: - Create

    // SUT with Mocked DAO to produce errors
    func testCreateError() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        let category = AudioCategory(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "createError"

        sut.createCategory(category: category) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.create)
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }

    // MARK: - Read

    func testGetAllCategoriesError() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        sut.getAllCategories({ (error, categoryArray) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.read)
            XCTAssertNil(categoryArray, "Array should be nil")
            closureExpectation.fulfill()
        })

        wait(for: [closureExpectation], timeout: 3.0)
    }
    // MARK: - Update

    // SUT with Mocked DAO to produce errors
    func testUpdateAllCategoriesError() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        sut.updateAllCategories { (error) in
           // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.update)
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }

    // MARK: - Delete

    // SUT with Mocked DAO to produce errors
    func testDeleteErrors() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        let category = AudioCategory(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "deleteError"

        sut.deleteCategory(category: category) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.delete)
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }
}
