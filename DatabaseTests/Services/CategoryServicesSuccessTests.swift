//
//  CategoryServicesSuccessTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Database
import CoreData

    // MARK: - Category Services

class CategoryServicesSuccessTests: XCTestCase {

    var sut: AudioCategoryServices!
    /// In order to create Category Entities
    var coreDataHelper: CoreDataTestHelper!
    /// Mocked Audio DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
    var categoryDAO: CategoryDAOMock!

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        categoryDAO = CategoryDAOMock()
        sut = AudioCategoryServices(dao: categoryDAO)

        // Category Services Success, therefore
        categoryDAO.shouldThrowError = false
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        // Audio should be flushed first because category cannot be nil
        coreDataHelper.flushData(from: "Audio")
        coreDataHelper.flushData(from: "Category")
        coreDataHelper = nil
        
        categoryDAO = nil
    }

    // MARK: - Create

    // Mock DAO does nothing, should not produce errors
    func testCreate() {
        let category = AudioCategory(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "create"

        sut.createCategory(category: category) { (error) in
            XCTAssertNil(error, "Services create error")
        }
    }

    // MARK: - Read

    func testGetAllCategories() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")
        // Category Array should contain exactly one record
        sut.getAllCategories { (error, categoryArray) in
            XCTAssertEqual(categoryArray?.count, 1, "AudioDAO Mock read func creates only 1 item not \(categoryArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }

    // MARK: - Update

    // Mock DAO does nothing, should not produce errors
    func testUpdateAllCategories() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        sut.updateAllCategories { (error) in
            XCTAssertNil(error, "Services update error")
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }

    // MARK: - Delete

    // Mock DAO does nothing, should not produce errors
    func testDelete() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        let category = AudioCategory(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        category.categoryName = "deleteError"

        sut.deleteCategory(category: category) { (error) in
            XCTAssertNil(error, "Services delete error")
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }
}
