/*
Copyright © 2020 MuseuZap. All rights reserved.

Abstract:
Services Layer. Independent from adopted database
Error Handling + doing aditional treatment to data

*/

import Foundation
import UIKit

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
            testes = try DAO.findAll()
            completion(nil, testes)
        } catch let error as DatabaseErrors {
            raisedError = error
            completion(raisedError, nil)
        } catch {
            print("Unexpected error: \(error).")
        }
    }

}
