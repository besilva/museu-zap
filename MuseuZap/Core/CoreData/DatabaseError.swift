//
//  DatabaseErrors.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

/// Possible Errors in database.
/// errorDescription is a friendlier message
public enum DatabaseErrors: Error {
    case create
    case read
    case update
    case delete
}

// Sobre localização: Fazer um enum com as strings para usar um único identifier quando formos localizar o App.
// Não vai ser essa mensagem que o usuário vai ver
extension DatabaseErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .create:
            return NSLocalizedString("Database could not create the desired record.", comment: "DatabaseErrors")
        case .read:
            return NSLocalizedString("Database does not contain any record of the wanted entity.", comment: "DatabaseErrors")
        case .update:
            return NSLocalizedString("Database could not update the desired record", comment: "DatabaseErrors")
        case .delete:
            return NSLocalizedString("Database could not delete the desired record.", comment: "DatabaseErrors")
        }
    }
}

// Let error: Error = MyError.customError
// Print(error.localizedDescription) // A user-friendly description of the error.
