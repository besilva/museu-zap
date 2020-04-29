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
        coreDataHelper.flushData(from: "Category")
        coreDataHelper = nil
        
        audioDAO = nil
    }

    // MARK: - Create

    // Mock DAO does nothing, should not produce errors
    func testCreate() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)

        sut.createAudio(audio: audio) { (error) in
            XCTAssertNil(error, "Services create error")
        }
    }

    // MARK: - Read

    func testGetAllAudios() {
        // Audio Array should contain exactly one record
        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(audioArray?.count, 1, "AudioDAO Mock readall func creates only 1 item not \(audioArray?.count ?? 100)!")
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
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)

        sut.deleteAudio(audio: audio) { (error) in
            XCTAssertNil(error, "Services delete error")
        }
    }
}
