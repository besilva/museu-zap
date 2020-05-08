//
//  FileErrors.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 08/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

/// Possible Errors while doing operations with Files
public enum FileErrors: Error {
    // Not a folder deveria ser usado pela extension no FileMAnager, em DatabaseKit
    case notAFolder
    case copy
    case listContents
}
