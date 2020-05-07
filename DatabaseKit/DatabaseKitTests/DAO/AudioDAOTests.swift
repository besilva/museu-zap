//
//  AudioDAOTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import DatabaseKit
import CoreData

    // MARK: - DAO

class AudioDAOTests: XCTestCase {

    var sut: AudioDAO!
    var coreDataHelper: CoreDataTestHelper!
    /// A Category Entity Object used to help to test AudioDAO, already saved in context
    var collaborator: DatabaseKit.AudioCategory!

    override func setUp() {
        // This method is called before the invocation of each test method in the class.
        coreDataHelper = CoreDataTestHelper()
        sut = AudioDAO(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        collaborator = coreDataHelper.initStubs()
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        // Audio should be flushed first because category cannot be nil
        coreDataHelper.flushData(from: "Audio")
        coreDataHelper.flushData(from: "AudioCategory")
        coreDataHelper = nil
        collaborator = nil
    }

    // MARK: - Create

    /// Creates a new Element (first without viewContext) and asserts if error is nil
    func testCreate() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)

        audio.audioName = "Mock audio create"
        audio.audioPath = "/Mocks/Path/"
        audio.duration = 5.44
        audio.isPrivate = false

        collaborator.addToAudios(audio)

        XCTAssertNoThrow(try sut.create(audio))
    }

    /// Creates a new Element (first without viewContext) and asserts if error is databaseCreate
    func testCreateError() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)

        collaborator.addToAudios(audio)

        XCTAssertThrowsError(try sut.create(audio), "Empty properties should throw error") { (error) in
           XCTAssertEqual(error as? DatabaseErrors, DatabaseErrors.create)
        }
    }

    // MARK: - Read

    /// Read mocked database, count should be igual to 3
    func testReadAll() {
        var audioArray = [Audio]()

        XCTAssertNoThrow(try audioArray = sut.readAll())
        XCTAssertEqual(audioArray.count, 3, "initStubs create only 3 item not \(audioArray.count)!")
    }

    // MARK: - Update

    /// Update saves the current context. Change the context and see if it was saved
    func testUpdate() {
        var databaseError: Error?
        var audioArray = [Audio]()
        var element: Audio?

        XCTAssertNoThrow(try audioArray = sut.readAll())

        element = audioArray[0]
        XCTAssertNotNil(element)

        do {
            element?.audioName = "Mock Name updated"
            try sut.updateContext()
            audioArray = try sut.readAll()
        } catch let error {
            databaseError = error
            print(databaseError ?? "databaseError update")
        }

        let audio = audioArray.first { (audio) -> Bool in
            return audio.audioName == "Mock Name updated"
        }

        XCTAssertNotNil(audio)
        XCTAssertEqual(audio?.audioName, "Mock Name updated", "Database was not updated")
        XCTAssertNil(databaseError, "databaseError update")
    }

    // MARK: - Delete

    /// Fetches the Elements, delete one and see if newArray count is two
    func testDelete() {
        var audioArray = [Audio]()
        var newArray = [Audio]()

        XCTAssertNoThrow(try audioArray = sut.readAll())

        let element = audioArray[0]

        XCTAssertNoThrow(try sut.delete(element))

        XCTAssertNoThrow(try newArray = sut.readAll())

        XCTAssertEqual(newArray.count, 2, "Database should have only two records")
    }

    /// Fetches the Elements, delete all and see if newArray count is zero
    func testDeleteAll() {
        var array = [Audio]()
        var newArray = [Audio]()

        XCTAssertNoThrow(try array = sut.readAll())

        let element = array[0]

        XCTAssertNoThrow(try sut.deleteAll(element))

        XCTAssertNoThrow(try newArray = sut.readAll())

        XCTAssertEqual(newArray.count, 0, "Database should have no records")
    }

    // MARK: - PREDICATE

    // Test method with NSpredicate to fetch only isPrivate=true audios
    func testPredicatePrivate() {
        var privateAudios = [Audio]()

        XCTAssertNoThrow(try privateAudios = sut.fetchAudiosWith(isPrivate: true))

        XCTAssertEqual(privateAudios.count, 1, "initStubs create only 1 private audio not \(privateAudios.count)!")
    }

    // Test method with NSpredicate to fetch only isPrivate=true audios
    func testPredicatePublic() {
        var publicAudios = [Audio]()

        XCTAssertNoThrow(try publicAudios = sut.fetchAudiosWith(isPrivate: false))

        XCTAssertEqual(publicAudios.count, 2, "initStubs create exactly 2 public audios not \(publicAudios.count)!")
    }
}
