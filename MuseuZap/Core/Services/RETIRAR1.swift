//
//  TesteServices.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import UIKit

/// Services Layer for Teste Entity.
/// Independent from adopted database.
/// Error Handling + doing aditional treatment to data.
class TesteServices {

    var DAO = TesteDAO()

    // MARK: - Get

    // Dao not async
    // Service handles error by casting it and gives it to ViewController
    func getAllTeste(_ completion: @escaping (_ errorMessage: Error?,
                                              _ entity: [Teste]?) -> Void) {
        // Error to be returned in case of failure
        var raisedError: DatabaseErrors?
        var testes: [Teste]?

        do {
            // Save information
            testes = try DAO.readAll()
            // FORCAR dao mockado produzir erro
            // Assert fail
            completion(nil, testes)
        } catch let error as DatabaseErrors { // TODO: vale a pena esse cast aqui?
            raisedError = error
            completion(raisedError, nil)
            // Assert success
        } catch {
            print("Unexpected error: \(error).")
        }
    }

}
