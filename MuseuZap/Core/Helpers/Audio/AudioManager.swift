//
//  AudioManager.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 12/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import AVFoundation
import MediaPlayer

/// Used to create observers
enum State: Equatable {
    case idle
    case playing(String)
    case paused(String)
}

/// Class used to play Audio Files
class AudioManager: NSObject {

    // MARK: - Properties

    /// Singleton
    static let shared = AudioManager()
    /// Remote Command Center
    var remoteCommandCenter: MPRemoteCommandCenter?
    /// MPNowPlayingInfoCenter
    var nowPlayingInfoCenter: MPNowPlayingInfoCenter?
    /// Notification Center, default
    let notificationCenter: NotificationCenter

    // Audio File
    /// PossibleAudioExtensions
    let possibleExtensions = [
        "m4a",
        "mp3"
    ]
    /// Model timed audiovisual media such as videos and sounds.
    /// For Play/Pause command, a check in the URL is performed to see if a new player should be created
    var audioAsset: AVURLAsset?
    /// To play an instance of AVAsset, initialize an instance of AVPlayerItem with it.
    /// Use the player item to set up its presentation state (such as whether only a limited timeRange of the asset should be played)
    var playerItem: AVPlayerItem?
    /// Provide the player item to an AVPlayer object to play an instance of AVAsset
    var player: AVPlayer?

    public private(set) var state = State.idle {
        // We add a property observer on 'state', which lets us run a function on each value change.
        didSet { stateDidChange() }
    }

    // MARK: - Init

    init(notificationCenter: NotificationCenter = NotificationCenter.default,
         nowPlayingInfoCenter: MPNowPlayingInfoCenter? = MPNowPlayingInfoCenter.default()) {
        self.notificationCenter = notificationCenter
        self.nowPlayingInfoCenter = nowPlayingInfoCenter
    }

    // MARK: - Change Status

    /// Play/Pause Command for wanted Audio. If the audio is new, override current player
    /// - Parameter file: Wanted audio to be played
    func changePlayerStatus(for file: URL) throws {

        // First verify if file is a Audio
        do {
            try verifyIfURLIsAudioFile(url: file)
        } catch {
            throw AudioErrors.noAudioFile
        }

        if file != audioAsset?.url {
            // If no player was created, there is no problem to pause a nil object
            // And if a new audio was clicked, stop current audio.
            player?.pause()
            // Change state when performing an action!
            state = .idle
            createPlayerFrom(file: file)
            // Update remote controllers info
            self.nowPlayingInfoCenter?.nowPlayingInfo = setupNowPlaying()
        }

        guard let audioPath = audioAsset?.url.path,
              let audioPlayer = player else {
            print("PLAYER COULD NOT BE INITIALIZED\n")
            throw AudioErrors.noPlayer
        }

        // Then change its status
        switch audioPlayer.timeControlStatus {
        case .paused:
            audioPlayer.play()
            changeState(state: .playing(audioPath))
        case .playing:
            audioPlayer.pause()
            changeState(state: .paused(audioPath))
        default:
            print("UNKNOWN CHANGE STATUS\n")
            throw AudioErrors.unknownCase
        }
    }
    
    func changeState( state: State) {
        self.state = state
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

    // MARK: - Helper

    /// Creates a AVAsset from file in order to get its duration in Seconds
    /// - Parameter file: URL from desired File
    /// - Returns: File duration in seconds. Returns 0 case file is no Media File
    func getDurationFrom(file: URL) -> TimeInterval {
       let asset = AVAsset(url: file)
       return CMTimeGetSeconds(asset.duration)
    }

    /// Ensures that URL file is a file, and that it is a AudioFile
    func verifyIfURLIsAudioFile(url: URL) throws {

        // Case URL is broken, throw error
        if !FileManager.default.fileExists(atPath: url.path) {
            throw FileErrors.invalidURL
        }

        // Verify if file is a AudioFile possible extension
        if !self.possibleExtensions.contains(url.pathExtension) {
            throw AudioErrors.noAudioFile
        }
    }
}

    // MARK: - Notification Center

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

    // TODO: add a observer to Notification.Name.AVPlayerItemDidPlayToEndTime
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

    // MARK: - Control center & iOS Lock Screen

extension AudioManager {
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
               self.changeState(state: .playing(audioPath))
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
                self.changeState(state: .paused(audioPath))
                return .success
            default:
                return .commandFailed
            }
        }

        remoteCommandCenter?.playCommand.isEnabled = true
        remoteCommandCenter?.pauseCommand.isEnabled = true
    }

    /// Update Remote properties, indicating which is the current audio playing
    func setupNowPlaying() -> [String: Any] {
        // Retrieve Current audio name
        guard let currentPlaying = audioAsset?.url.deletingPathExtension().lastPathComponent else {
            print("AUDIO URL NIL!")
            return [:]
        }

        // Define Now Playing Info
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = currentPlaying
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.playerItem?.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player?.rate
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.playerItem?.currentTime().seconds
        if let image = UIImage(named: "ShareIcon") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { _ in // Size
                    return image
            }
        }

        // Return the metadata
        return nowPlayingInfo
    }
}
