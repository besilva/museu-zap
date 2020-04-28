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

// TODO: como jogar o erro para cima usando os enums?

    // MARK: - AudioDAOMock

class AudioDAOMock: AudioDAOProtocol {

    // TODO: nunca vai ser mudado aqui..

    var shouldThrowError: Bool = true
    var coreDataHelper = CoreDataTestHelper()

    func create(_ objectToBeSaved: Audio) throws {
        if shouldThrowError {
            throw DatabaseErrors.create
        } else {

        }
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

    func testCreate() {

    }

    // MARK: - Read

    /// Creates a new Element (first without viewContext) and asserts if error is nil
    func testGetAllAudios() {

        // Audio Array should contain exactly one record
        sut.getAllAudios { (error, audioArray) in
            XCTAssertEqual(audioArray?.count, 1, "AudioDAO Mock create func creates only 1 item not \(audioArray?.count ?? 100)!")
            XCTAssertNil(error, "Services get error")
        }

    }

    // MARK: - Update

    // MARK: - Delete

}
