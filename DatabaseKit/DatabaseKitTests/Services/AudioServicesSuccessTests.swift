//
//  AudioServicesSuccessTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import DatabaseKit
import CoreData

    // MARK: - Audio Services

class AudioServicesSuccessTests: XCTestCase {

    var sut: AudioServices!
    /// In order to create Audio Entities
    var coreDataHelper: CoreDataTestHelper!
    /// Mocked Audio DAO to throw DatabaseErrors, case shouldThrowError. Else, do nothing.
    var audioDAO: AudioDAOMock!

    override func setUp() {
        coreDataHelper = CoreDataTestHelper()
        audioDAO = AudioDAOMock()
        sut = AudioServices(dao: audioDAO)

        // Audio Services Success, therefore
        audioDAO.shouldThrowError = false
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        // Audio should be flushed first because category cannot be nil
        coreDataHelper.flushData(from: "Audio")
        coreDataHelper.flushData(from: "AudioCategory")
        coreDataHelper = nil
        
        audioDAO = nil
    }

    // MARK: - Create

    // Mock DAO does nothing, should not produce errors
    func testCreate() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        sut.createAudio(audio: audio) { (error) in
            XCTAssertNil(error, "Services create error")
            closureExpectation.fulfill()
        }
        
        wait(for: [closureExpectation], timeout: 3.0)
    }

    // MARK: - Read

    func testGetAllAudios() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")
        // Audio Array should contain exactly one record
        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(audioArray?.count, 1, "AudioDAO Mock readall func creates only 1 item not \(audioArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }

    // MARK: - Update

    // Mock DAO does nothing, should not produce errors
    func testUpdateAllAudios() {
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")
        
        sut.updateAllAudios { (error) in
             XCTAssertNil(error, "Services update error")
             closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }

    // MARK: - Delete
    
    // Mock DAO does nothing, should not produce errors
    func testDelete() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        let closureExpectation = XCTestExpectation(description: "Expect to call closure")

        sut.deleteAudio(audio: audio) { (error) in
            XCTAssertNil(error, "Services delete error")
            closureExpectation.fulfill()
        }

        wait(for: [closureExpectation], timeout: 3.0)
    }
}
