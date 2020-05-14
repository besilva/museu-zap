//
//  AudioManager.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 12/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import AVFoundation
import MediaPlayer
import DatabaseKit

/// Used to create observers
enum State {
    case idle
    case playing(_ url: String? = nil)
    case paused(_ url: String? = nil)
}

/// Class used to play Audio Files
class AudioManager: NSObject {

    // MARK: - Properties

    /// Singleton
    static let shared = AudioManager()
    /// Remote Command Center
    var remoteCommandCenter: MPRemoteCommandCenter?
    /// Notification Center, default
    let notificationCenter: NotificationCenter

    // Audio File
    /// Audio Entity, generated from URL
    // TODO: state passa audioPath ou propria entidade audio?
    var currentAudio: Audio?
    /// Model timed audiovisual media such as videos and sounds.
    /// For Play/Pause command, a check in the URL is performed to see if a new player should be created
    var audioAsset: AVURLAsset?
    /// To play an instance of AVAsset, initialize an instance of AVPlayerItem with it.
    /// Use the player item to set up its presentation state (such as whether only a limited timeRange of the asset should be played)
    var playerItem: AVPlayerItem?
    /// Provide the player item to an AVPlayer object to play an instance of AVAsset
    var player: AVPlayer?

    private var state = State.idle {
        // We add a property observer on 'state', which lets us run a function on each value change.
        didSet { stateDidChange() }
    }

    // MARK: - Init

    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }

    // MARK: - Change Status

    /// Play/Pause Command for wanted Audio. If the audio is new, override current player
    /// - Parameter file: Wanted audio to be played
    func changePlayerStatus(for file: URL) throws {

        // First, ensure that there is a player
        if file != audioAsset?.url {
            // If no player was created, there is no problem to pause a nil object
            // And if a new audio was clicked, stop currect audio.
            player?.pause()
            state = .idle
            createPlayerFrom(file: file)
            // Update remote controllers info
            setupNowPlaying()
        }

        guard let audioPath = audioAsset?.url.path else {
            print("AUDIO URL NIL!")
            throw AudioErrors.noPlayer
        }

        guard let audioPlayer = player else {
            print("PLAYER COULD NOT BE INITIALIZED")
            throw AudioErrors.noPlayer
        }

        // Then change its status
        switch audioPlayer.timeControlStatus {
        case .paused:
            audioPlayer.play()
            state = .playing(audioPath)
        case .playing:
            audioPlayer.pause()
            state = .paused(audioPath)
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

        // Create a new AVPlayerItem with the asset and an
        // Array of asset keys to be automatically loaded
        playerItem = AVPlayerItem(asset: audioAsset!,
                                  automaticallyLoadedAssetKeys: assetKeys)

        // Associate the player item with the player
        player = AVPlayer(playerItem: playerItem)
    }

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

        // Add handler for Play Command, passes audioPath when state changed
        remoteCommandCenter?.playCommand.addTarget { [unowned self] _ in // Event

            guard let audioPath = self.audioAsset?.url.path else {
                print("AUDIO URL NIL!")
                return .commandFailed
            }

            switch self.player?.timeControlStatus {
            case .paused:
               self.player?.play()
               self.state = .playing(audioPath)
               return .success
            default:
                return .commandFailed
            }
        }

        // Add handler for Pause Command, passes audioPath when state changed
        remoteCommandCenter?.pauseCommand.addTarget { [unowned self] _ in // Event

            guard let audioPath = self.audioAsset?.url.path else {
                print("AUDIO URL NIL!")
                return .commandFailed
            }

            switch self.player?.timeControlStatus {
            case .playing:
                self.player?.pause()
                self.state = .paused(audioPath)
                return .success
            default:
                return .commandFailed
            }
        }

        remoteCommandCenter?.playCommand.isEnabled = true
        remoteCommandCenter?.pauseCommand.isEnabled = true
    }

    /// Update Remote properties, indicating which is the current audio playing
    func setupNowPlaying() {
        // Retrieve Current audio name
        guard let currentPlaying = audioAsset?.url.deletingPathExtension().lastPathComponent else {
            print("AUDIO URL NIL!")
            return
        }

        // Define Now Playing Info
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = currentPlaying

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

    // MARK: - NOTIFICATION CENTER

extension AudioManager {
    func stateDidChange() {
        switch state {
        case .playing(let audio):
            notificationCenter.post(name: .playbackStarted, object: audio)
        case .paused(let audio):
            notificationCenter.post(name: .playbackPaused, object: audio)
        case .idle:
            notificationCenter.post(name: .playbackStopped, object: nil)
        }
    }
}

// This extension should be placed here because state is private
extension Notification.Name {

    /// Playing
    static var playbackStarted: Notification.Name {
        return .init(rawValue: "AudioManager.playbackStarted")
    }

    /// Pause
    static var playbackPaused: Notification.Name {
        return .init(rawValue: "AudioManager.playbackPaused")
    }

    /// Idle
    static var playbackStopped: Notification.Name {
            return .init(rawValue: "AudioManager.playbackStopped")
    }
}
