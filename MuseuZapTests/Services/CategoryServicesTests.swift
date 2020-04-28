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

// TODO: como jogar o erro para cima usando os enums? Se faço cast como DatabaseErros, qnd dou print pego apenas o nome

    // MARK: - AudioDAOMock

class CategoryDAOMock: CategoryDAOProtocol {

    // TODO: COMO alternar as funcoes do mock para produzirem erro???

    var coreDataHelper = CoreDataTestHelper()

    func create(_ objectToBeSaved: MuseuZap.Category) throws {
    }

    func readAll() throws -> [MuseuZap.Category] {
        let category = Category(container: coreDataHelper.mockPersistantContainer)
        return [category]
    }

    func updateContext() throws {
    }

    func delete(_ objectToBeDeleted: MuseuZap.Category) throws {
    }

    func deleteAll(_ objectToBeDeleted: MuseuZap.Category) throws {
    }

    // MARK: - CRUD ERRORS

    func readAllError() throws -> [MuseuZap.Category] {
        throw DatabaseErrors.read
    }

}

    // MARK: - Audio Services

class CategoryServicesTests: XCTestCase {

    var sut: CategoryServices!
    var coreDataHelper: CoreDataTestHelper!

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        sut = CategoryServices(dao: CategoryDAOMock())
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
        let category = Category(container: coreDataHelper.mockPersistantContainer)

        sut.createCategory(category: category) { (error) in
            XCTAssertNil(error, "Services create error")
        }
    }

    // MARK: - Read

    func testGetAllAudios() {
        // Category Array should contain exactly one record
        sut.getAllCategories { (error, categoryArray) in
            XCTAssertEqual(categoryArray?.count, 1, "AudioDAO Mock create func creates only 1 item not \(categoryArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
        }

    }

    // MARK: - Update

    // Mock DAO does nothing, should not produce errors
    func testUpdateAllAudios() {

        sut.updateAllCategories { (error) in
            XCTAssertNil(error, "Services update error")
        }
    }

    // MARK: - Delete

    // Mock DAO does nothing, should not produce errors
    func testDelete() {
        let category = Category(container: coreDataHelper.mockPersistantContainer)

        sut.deleteCategory(category: category) { (error) in
            XCTAssertNil(error, "Services delete error")
        }

    }

    // MARK: - FAIL TESTS

//    func testGetAllAudiosError() {
//
//        XCTAssertThrowsError(try sut.getAllAudios({ (_, _) in
//        })) { error in
//            XCTAssertEqual(error as! DatabaseErrors, DatabaseErrors.read)
//        }
//    }

}
