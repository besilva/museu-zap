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

class AudioDAOMock: AudioDAOProtocol {

    // TODO: COMO alternar as funcoes do mock para produzirem erro???

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

    // MARK: - CRUD ERRORS

    func readAllError() throws -> [Audio] {
        throw DatabaseErrors.read
    }

}

    // MARK: - Audio Services

class AudioServicesTests: XCTestCase {

    var sut: AudioServices!
    var coreDataHelper: CoreDataTestHelper!

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        sut = AudioServices(dao: AudioDAOMock())
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

    // MARK: - Read

    func testGetAllAudios() {
        // Audio Array should contain exactly one record
        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(audioArray?.count, 1, "AudioDAO Mock create func creates only 1 item not \(audioArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
        }
    }

    // MARK: - Update

    // Mock DAO does nothing, should not produce errors
    func testUpdateAllAudios() {

        sut.updateAllAudios { (error) in
            XCTAssertNil(error, "Services update error")
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
    // MARK: - FAIL TESTS

//    func testGetAllAudiosError() {
//
//        XCTAssertThrowsError(try sut.getAllAudios({ (_, _) in
//        })) { error in
//            XCTAssertEqual(error as! DatabaseErrors, DatabaseErrors.read)
//        }
//    }

}
