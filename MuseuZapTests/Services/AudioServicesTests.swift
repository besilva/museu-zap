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

    // MARK: - Audio Services

class AudioServicesTests: XCTestCase {

    var sut: AudioServices!
    /// Sistem under Test with Mocked DAO to produce errors
    var sutErrors: AudioServices!
    var coreDataHelper: CoreDataTestHelper!

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        sut = AudioServices(dao: AudioDAOMock())

        sutErrors = AudioServices(dao: AudioDAOMockErrors())
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
        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sut.createAudio(audio: audio) { (error) in
            XCTAssertNil(error, "Services create error")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testCreateError() {
        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sutErrors.createAudio(audio: audio) { (error) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.create)
        }
    }

    // MARK: - Read

    func testGetAllAudios() {
        // Audio Array should contain exactly one record
        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(audioArray?.count, 1, "AudioDAO Mock create func creates only 1 item not \(audioArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
        }
    }

    func testGetAllAudiosError() {

        sutErrors.getAllAudios { (error, audioArray) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.read)
            XCTAssertNil(audioArray, "Array should be nil")
        }
    }

    // MARK: - Update

    // Mock DAO does nothing, should not produce errors
    func testUpdateAllAudios() {

        sut.updateAllAudios { (error) in
            XCTAssertNil(error, "Services update error")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testUpdateAllAudiosError() {

        sut.updateAllAudios { (error) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.update)
        }
    }

    // MARK: - Delete
    
    // Mock DAO does nothing, should not produce errors
    func testDelete() {
        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sut.deleteAudio(audio: audio) { (error) in
            XCTAssertNil(error, "Services delete error")
        }
    }

    // SUT with Mocked DAO to produce errors
    func testDeleteErrors() {
        let audio = Audio(container: coreDataHelper.mockPersistantContainer)

        sut.deleteAudio(audio: audio) { (error) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.delete)
        }
    }

}

// MARK: - DAO mocks

class AudioDAOMock: AudioDAOProtocol {

    var coreDataHelper = CoreDataTestHelper()

    func create(_ objectToBeSaved: Audio) throws {
    }

    func readAll() throws -> [Audio] {
        let audio = Audio(container: coreDataHelper.mockPersistantContainer)
        return [audio]
    }

    func updateContext() throws {
    }

    func delete(_ objectToBeDeleted: Audio) throws {
    }

    func deleteAll(_ objectToBeDeleted: Audio) throws {
    }

}

/// Mocked DAO to throw DatabaseErrors
class AudioDAOMockErrors: AudioDAOProtocol {
    func create(_ objectToBeSaved: Audio) throws {
        throw DatabaseErrors.create
    }

    func readAll() throws -> [Audio] {
        throw DatabaseErrors.read
    }

    func updateContext() throws {
        throw DatabaseErrors.update
    }

    func delete(_ objectToBeDeleted: Audio) throws {
        throw DatabaseErrors.delete
    }

    func deleteAll(_ objectToBeDeleted: Audio) throws {
        throw DatabaseErrors.delete
    }

}
