//
//  DatabaseErrors.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

/// Errors in database.
/// errorDescription is a friendlier message
public enum DatabaseErrors: Error {
    case fetch
}

extension DatabaseErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fetch:
            return NSLocalizedString("Database does not contain any record of the wanted entity.", comment: "DatabaseErrors")
        }
    }
}

// Let error: Error = MyError.customError
// Print(error.localizedDescription) // A user-friendly description of the error.
