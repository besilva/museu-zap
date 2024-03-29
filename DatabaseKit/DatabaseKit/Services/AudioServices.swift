//
//  AudioServices.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

// MARK: - Protocol For test purpose

public protocol AudioServicesProtocol {
    // CRUD Operations: Create, Read, Update, Delete
    func createAudio(audio: Audio, _ completion: ((_ error: Error?) -> Void))
    func getAllAudios(_ completion: @escaping (_ errorMessage: Error?,
                                               _ entity: [Audio]?) -> Void)
    func getAllAudiosWith(isPrivate bool: Bool, _ completion: @escaping (_ errorMessage: Error?,
                                                                         _ entity: [Audio]?) -> Void)
    func updateAllAudios(_ completion: (_ error: Error?) -> Void)
    func deleteAudio(audio: Audio, _ completion: (_ error: Error?) -> Void)
}

/// Services Layer for Audio Entity.
/// Independent from adopted database.
/// Error Handling + doing aditional treatment to data.
public class AudioServices: AudioServicesProtocol {

    /// Used Data Access Object
    var audioDAO: AudioDAOProtocol

    // Dependency Injection in order to make a testable class
    required public init(dao: AudioDAOProtocol) {
        self.audioDAO = dao
    }

    public convenience init () {
        self.init(dao: AudioDAO())
    }

    // MARK: - Create

    /// Function responsible for storing an Audio
    /// - parameters:
    ///     - audio: Audio to be Saved
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.create)
    public func createAudio(audio: Audio, _ completion: ((_ error: Error?) -> Void)) {
        do {
            // Save information
            try audioDAO.create(audio)
            completion(nil)
        } catch let error as DatabaseErrors {
            completion(error)
        } catch {
            completion(error)
            print("Unexpected error: \(error).")
        }
    }

    // MARK: - Read

    /// Function responsible for getting all Audios
    /// - parameters:
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during getting an object from database  (DatabaseErrors.read)
    public func getAllAudios(_ completion: @escaping (_ errorMessage: Error?,
                                               _ entity: [Audio]?) -> Void) {
        // Error to be returned in case of failure
        var raisedError: DatabaseErrors?
        var audios: [Audio]?

        do {
            audios = try audioDAO.readAll()
            completion(nil, audios)
        } catch let error as DatabaseErrors {
            raisedError = error
            completion(raisedError, nil)
        } catch {
            completion(error, nil)
            print("Unexpected error: \(error).")
        }
    }

    /// Function responsible for getting all Audios that have isPrivate = true or = false
    /// - parameters:
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during getting an object from database  (DatabaseErrors.publicAndPrivate)
    public func getAllAudiosWith(isPrivate bool: Bool, _ completion: @escaping (_ errorMessage: Error?,
                                                                         _ entity: [Audio]?) -> Void) {
        // Error to be returned in case of failure
        var raisedError: DatabaseErrors?
        var audios: [Audio]?

        do {
            audios = try audioDAO.fetchAudiosWith(isPrivate: bool)
            completion(nil, audios)
        } catch let error as DatabaseErrors {
            raisedError = error
            completion(raisedError, nil)
        } catch {
            completion(error, nil)
            print("Unexpected error: \(error).")
        }
    }

    // MARK: - Update

    /// Function responsible for updating all audio records
    /// - parameters:
    ///     - audio: Audio to be updated
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.update)
    public func updateAllAudios(_ completion: (_ error: Error?) -> Void) {
        do {
            // Save information
            try audioDAO.updateContext()
            completion(nil)
        } catch let error as DatabaseErrors {
           completion(error)
        } catch {
           completion(error)
           print("Unexpected error: \(error).")
        }
    }

    // MARK: - Delete

    /// Function responsible for deleting an Audio
    /// - parameters:
    ///     - audio: audio to be deleted
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.delete)
    public func deleteAudio(audio: Audio, _ completion: (_ error: Error?) -> Void) {
        do {
            // Save information
            try audioDAO.delete(audio)
            completion(nil)
        } catch let error as DatabaseErrors {
           completion(error)
        } catch {
           completion(error)
           print("Unexpected error: \(error).")
        }
    }
    
}
