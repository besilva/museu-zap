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

    required init(dao: AudioDAO) {
        self.DAO = dao
    }

    /// Used Data Access Object
    var DAO = AudioDAO()

    // MARK: - Get

    // Dao not async
    // Service handles error by casting it and gives it to ViewController
    func getAllAudios(_ completion: @escaping (_ errorMessage: Error?,
                                              _ entity: [Audio]?) -> Void) {
        // Error to be returned in case of failure
        var raisedError: DatabaseErrors?
        var audios: [Audio]?

        do {
            // Save information
            audios = try DAO.readAll()
            // FORCAR dao mockado produzir erro
            // Assert fail
            completion(nil, audios)
        } catch let error as DatabaseErrors { // TODO: vale a pena esse cast aqui?
            raisedError = error
            completion(raisedError, nil)
            // Assert success
        } catch {
            print("Unexpected error: \(error).")
        }
    }

}
