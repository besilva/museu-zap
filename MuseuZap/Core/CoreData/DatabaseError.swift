/*
Copyright © MuseuZap. All rights reserved.

Abstract:
Errors in database
errorDescription is a friendlier message

*/

import Foundation

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
