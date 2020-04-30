//
//  AudioDAOMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

@testable import MuseuZap
import CoreData

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
            let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
            return [audio]
        }
    }

    func fetchAudiosWith(isPrivate: Bool) throws -> [Audio] {
        if shouldThrowError {
            throw DatabaseErrors.publicAndPrivate
        } else {
            let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
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

    func getPublicAudios() throws -> [Audio] {
        return [Audio()]
    }

    func getAllPrivateAudios() throws -> [Audio] {
         return [Audio()]
    }
}
