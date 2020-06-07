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
/// Original errors are always printed before
public enum DatabaseErrors: Error {
    case create
    case read
    case update
    case delete
    case publicAndPrivate
}
