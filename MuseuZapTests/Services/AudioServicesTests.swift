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

    // MARK: - Audio Services

class AudioServicesTests: XCTestCase {

    var sut: AudioServices!
    /// In order to create Audio Entities
    var coreDataHelper: CoreDataTestHelper!
    /// Mocked Audio DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
    let audioDAO = AudioDAOMock()

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        sut = AudioServices(dao: audioDAO)
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
        audioDAO.shouldThrowError = false

        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sut.createAudio(audio: audio) { (error) in
            print("Services create error", error as Any)
            XCTFail("Closure should not be invoked")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testCreateError() {
        audioDAO.shouldThrowError = true

        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sut.createAudio(audio: audio) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.create)
        }
    }

    // MARK: - Read

    func testGetAllAudios() {
        audioDAO.shouldThrowError = false

        // Audio Array should contain exactly one record
        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(audioArray?.count, 1, "AudioDAO Mock create func creates only 1 item not \(audioArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
        }
    }

    func testGetAllAudiosError() {
        audioDAO.shouldThrowError = true

        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.read)
            XCTAssertNil(audioArray, "Array should be nil")
        }
    }

    // MARK: - Update

    // Mock DAO does nothing, should not produce errors
    func testUpdateAllAudios() {
        audioDAO.shouldThrowError = false

        sut.updateAllAudios { (error) in
            print("Services update error", error as Any)
            XCTFail("Closure should not be invoked")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testUpdateAllAudiosError() {
        audioDAO.shouldThrowError = true

        sut.updateAllAudios { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.update)
        }
    }

    // MARK: - Delete
    
    // Mock DAO does nothing, should not produce errors
    func testDelete() {
        audioDAO.shouldThrowError = false

        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sut.deleteAudio(audio: audio) { (error) in
            print("Services update error", error as Any)
            XCTFail("Closure should not be invoked")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testDeleteErrors() {
        audioDAO.shouldThrowError = true

        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sut.deleteAudio(audio: audio) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.delete)
        }
    }

}

// MARK: - DAO mocks

/// Mocked Audio DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
class AudioDAOMock: AudioDAOProtocol {

    var shouldThrowError: Bool = false

    var coreDataHelper = CoreDataTestHelper()

    func create(_ objectToBeSaved: Audio) throws {
        if shouldThrowError {
            throw DatabaseErrors.create
        }
    }

    func readAll() throws -> [Audio] {
        if shouldThrowError {
            throw DatabaseErrors.read
        } else {
            let audio = Audio(container: coreDataHelper.mockPersistantContainer)
            return [audio]
        }
    }

    func updateContext() throws {
        if shouldThrowError {
            throw DatabaseErrors.update
        }
    }

    func delete(_ objectToBeDeleted: Audio) throws {
        if shouldThrowError {
            throw DatabaseErrors.delete
        }
    }

    func deleteAll(_ objectToBeDeleted: Audio) throws {
        if shouldThrowError {
            throw DatabaseErrors.delete
        }
    }

}
