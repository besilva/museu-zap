//
//  AudioManager.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 12/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import AVFoundation
import MediaPlayer

/// Class used to play Audio Files
class AudioManager {

    /// Singleton
    static let shared = AudioManager()

    /// Creates a AVAsset from file in order to get its duration in Seconds
    /// - Parameter file: URL from desired File
    /// - Returns: File duration in seconds. Returns 0 case file is no Media File
    func getDurationFrom(file: URL) -> TimeInterval {
       let asset = AVAsset(url: file)
       return CMTimeGetSeconds(asset.duration)
    }

}
