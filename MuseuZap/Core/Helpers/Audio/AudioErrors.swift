//
//  AudioErrors.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 12/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

/// Possible Errors while doing operations with Files
public enum AudioErrors: Error {

    case noPlayer
    case noAudioFile
    case unknownCase
}
