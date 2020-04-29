//
//  AudioServicesErrorTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap
import CoreData

    // MARK: - Audio Services

class AudioServicesErrorTests: XCTestCase {

    var sut: AudioServices!
    /// In order to create Audio Entities
    var coreDataHelper: CoreDataTestHelper!
    /// Mocked Audio DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
    var audioDAO: AudioDAOMock!

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        audioDAO = AudioDAOMock()
        sut = AudioServices(dao: audioDAO)

        // Audio Services Error, therefore
        audioDAO.shouldThrowError = true
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        // Audio should be flushed first because category cannot be nil
        coreDataHelper.flushData(from: "Audio")
        coreDataHelper.flushData(from: "Category")
        coreDataHelper = nil

        audioDAO = nil
    }

    // MARK: - Create

    // SUT with Mocked DAO to produce errors
    func testCreateError() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)

        sut.createAudio(audio: audio) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.create)
        }
    }

    // MARK: - Read

    func testGetAllAudiosError() {
        audioDAO.shouldThrowError = true

        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.read)
            XCTAssertNil(audioArray, "Array should be nil")
        }
    }

    // MARK: - Update

    // SUT with Mocked DAO to produce errors
    func testUpdateAllAudiosError() {

        sut.updateAllAudios { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.update)
        }
    }

    // MARK: - Delete

    // SUT with Mocked DAO to produce errors
    func testDeleteErrors() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)

        sut.deleteAudio(audio: audio) { (error) in
            // Closure only invoked if there was error
            XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.delete)
        }
    }

}
