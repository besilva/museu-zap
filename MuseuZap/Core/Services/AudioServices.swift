//
//  AudioServices.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

/// Services Layer for Audio Entity.
/// Independent from adopted database.
/// Error Handling + doing aditional treatment to data.
class AudioServices {

    /// Used Data Access Object
    var DAO: AudioDAOProtocol

    // Dependency Injection in order to make a testable class
    required init(dao: AudioDAOProtocol) {
        self.DAO = dao
    }

    // MARK: - Create

    /// Function responsible for storing an Audio
    /// - parameters:
    ///     - audio: Audio to be Saved
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.create)
    func createAudio(audio: Audio, _ completion: ((_ error: Error?) -> Void)?) {
        do {
            // Save information
            try DAO.create(audio)
        } catch {
            if let closureError = completion {
                closureError(error)
            } else {
                print("AUDIO SERVICES UNKNOWN ERROR", error)
            }
        }
    }

    // MARK: - Read

    /// Function responsible for getting all Audios
    /// - parameters:
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during getting an object from database  (DatabaseErrors.read)
    func getAllAudios(_ completion: @escaping (_ errorMessage: Error?,
                                               _ entity: [Audio]?) -> Void) {
        // Error to be returned in case of failure
        var raisedError: DatabaseErrors?
        var audios: [Audio]?

        do {
            // Save information
            audios = try DAO.readAll()
            completion(nil, audios)
        } catch let error as DatabaseErrors {
            // Vale a pena do ponto de vista do usuario
            // Tambem ter esse tratamento diferente na camada de cima.
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
    func updateAllAudios(errorCompletion: ((_ error: Error?) -> Void)?) {
        do {
            // Save information
            try DAO.updateContext()
        } catch let error {
            if let closureError = errorCompletion {
                closureError(error)
            } else {
                print(error)
            }
        }
    }

    // MARK: - Delete

    /// Function responsible for deleting an Audio
    /// - parameters:
    ///     - audio: audio to be deleted
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.delete)
    func deleteAudio(audio: Audio, _ completion: ((_ error: Error?) -> Void)?) {
        do {
            // Save information
            try DAO.delete(audio)
        } catch let error {
            if let closureError = completion {
                closureError(error)
            } else {
                print(error)
            }
        }
    }
    
}
