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
class AudioManager: NSObject {

    // MARK: - Properties

    /// Singleton
    static let shared = AudioManager()
    /// Remote Commnad Center
    var remoteCommandCenter: MPRemoteCommandCenter?

    // Audio File
    /// Model timed audiovisual media such as videos and sounds.
    /// For Play/Pause command, a check in the URL is performed to see if a new player should be created
    var audioAsset: AVURLAsset?
    /// To play an instance of AVAsset, initialize an instance of AVPlayerItem with it.
    /// Use the player item to set up its presentation state (such as whether only a limited timeRange of the asset should be played)
    var playerItem: AVPlayerItem?
    /// Provide the player item to an AVPlayer object to play an instance of AVAsset
    var player: AVPlayer?

    // MARK: - Change Status

    /// Play/Pause Command for wanted Audio. If the audio is new, override current player
    /// - Parameter file: Wanted audio to be played
    func changePlayerStatus(for file: URL) throws {

        // First, ensure that there is a player
        if file != audioAsset?.url {
            // If no player was created, there is no problem to pause a nil object
            // And if a new audio was clicked, stop currect audio.
            player?.pause()
            createPlayerFrom(file: file)
        }

        guard let audioPlayer = player else {
            print("PLAYER COULD NOT BE INITIALIZED")
            throw AudioErrors.noPlayer
        }

        // Then change its status
        switch audioPlayer.timeControlStatus {
        case .paused:
            audioPlayer.play()
        case .playing:
            audioPlayer.pause()
        default:
            print("UNKNOWN CHANGE STATUS \n")
        }
    }

    // MARK: - SetUp

    func createPlayerFrom(file: URL) {
        audioAsset = AVURLAsset(url: file, options: [:])

        let assetKeys = [
            "playable",
            "duration"
        ]

        // Ensures that old observer is removed
//        player?.removeObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus))

        // Create a new AVPlayerItem with the asset and an
        // Array of asset keys to be automatically loaded
        playerItem = AVPlayerItem(asset: audioAsset!,
                                  automaticallyLoadedAssetKeys: assetKeys)

        // Associate the player item with the player
        player = AVPlayer(playerItem: playerItem)

        // Register as an observer of the player "is Playing" status
//        player?.addObserver(self,
//                            forKeyPath: #keyPath(AVPlayer.timeControlStatus),
//                            options: [.old, .new],
//                            context: nil)
    }

//    override func observeValue(forKeyPath keyPath: String?,
//                               of object: Any?,
//                               change: [NSKeyValueChangeKey : Any]?,
//                               context: UnsafeMutableRawPointer?) {
//
//        if keyPath == #keyPath(AVPlayer.timeControlStatus) {
//            let status: AVPlayer.TimeControlStatus
//
//            // Get the status change from the change dictionary
//            if let statusNumber = change?[.newKey] as? NSNumber {
//                status = AVPlayer.TimeControlStatus(rawValue: statusNumber.intValue)!
//            } else {
//                // If could not cast, let it fall into default case
//                status = .waitingToPlayAtSpecifiedRate
//            }
//
//            // Switch over the status
//            switch status {
//            case .paused:
//                print("MUDEI PRO paused \n")
//            case .playing:
//                print("MUDEI PRO PLAY \n")
//            default:
//                print("UNKNOWN CHANGE STATUS OBSERVER \n")
//            }
//        }
//    }

        // MARK: - AVAudioSession SetUp

        /// Configure the AVAudioSession. Called in AppDelegate
        /// Together with  Background Mode Capability, Playback category lets the audio play when the App goes to background, or screenLock
        func configureAVAudioSession() {
            let audioSession = AVAudioSession.sharedInstance()

            do {
                // Set the audio session category, mode and options.
                try audioSession.setCategory(.playback,
                                             mode: .default,
                                             options: [])
                try audioSession.setActive(true)
            } catch {
                print("COULD NOT CONFIGURE AVSESSION", error)
            }
        }

        // MARK: - Control center & iOS Lock Screen

         /// Allow audio to be controlled from Control Center and iOS Lock screen.
         func setupRemoteTransportControls() {
            // Get the shared MPRemoteCommandCenter
            remoteCommandCenter = MPRemoteCommandCenter.shared()

            // Add handler for Play Command
            remoteCommandCenter?.playCommand.addTarget { [unowned self] _ in // Event
                switch self.player?.timeControlStatus {
                case .paused:
                   self.player?.play()
                   return .success
                default:
                    return .commandFailed
                }
            }

            // Add handler for Pause Command
            remoteCommandCenter?.pauseCommand.addTarget { [unowned self] _ in // Event
                switch self.player?.timeControlStatus {
                case .playing:
                    self.player?.pause()
                    return .success
                default:
                    return .commandFailed
                }
            }

            remoteCommandCenter?.playCommand.isEnabled = true
            remoteCommandCenter?.pauseCommand.isEnabled = true

            setupNowPlaying()
         }

        func setupNowPlaying() {
            // Define Now Playing Info
            var nowPlayingInfo = [String: Any]()
            // TODO: colocar titulo da propriedade aqui
            nowPlayingInfo[MPMediaItemPropertyTitle] = "Movie Title NEW"
            nowPlayingInfo[MPMediaItemPropertyArtist] = "Artist Name NEW"

            if let image = UIImage(named: "ShareIcon") {
                nowPlayingInfo[MPMediaItemPropertyArtwork] =
                    MPMediaItemArtwork(boundsSize: image.size) { _ in // Size
                        return image
                }
            }

            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.playerItem?.currentTime().seconds
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.playerItem?.asset.duration.seconds
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player?.rate

            // Set the metadata
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }

    // MARK: - Helper

    /// Creates a AVAsset from file in order to get its duration in Seconds
    /// - Parameter file: URL from desired File
    /// - Returns: File duration in seconds. Returns 0 case file is no Media File
    func getDurationFrom(file: URL) -> TimeInterval {
       let asset = AVAsset(url: file)
       return CMTimeGetSeconds(asset.duration)
    }
}
