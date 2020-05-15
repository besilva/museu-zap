//
//  AudioManagerTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 13/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
import MediaPlayer
@testable import MuseuZap

class AudioManagerTestsSuccess: XCTestCase {

    var sut: AudioManager!
    var sampleAudio: URL!
    var nowPlayingInfos: [String: Any]?

    override func setUp() {
        sut = AudioManager(notificationCenter: MockedNotificationCenter(), nowPlayingInfoCenter: nil)

        // Sample Audio has to be target to main Application
        let path = Bundle.main.path(forResource: "AudioManagerTest", ofType: "m4a")!
        sampleAudio = URL(fileURLWithPath: path, isDirectory: false)

        // Artwork cannot be equal, so it will not be compared.
        // Sample Audio Infos
        nowPlayingInfos = [
            MPMediaItemPropertyTitle: "AudioManagerTest",
            MPMediaItemPropertyPlaybackDuration: 3.456,
            MPNowPlayingInfoPropertyPlaybackRate: Float(0.0),
            MPNowPlayingInfoPropertyElapsedPlaybackTime: 0.0
        ]
    }

    override func tearDown() {
        // Since singleton will be used, just set all the properties back to nil
        sut = AudioManager()
        sampleAudio = nil
        nowPlayingInfos = nil
    }

    // MARK: - CreatePlayer

    func testCreatePlayerFrom() {
        sut.createPlayerFrom(file: sampleAudio)

        XCTAssertNotNil(sut.audioAsset)
        XCTAssertNotNil(sut.playerItem)
        XCTAssertNotNil(sut.player)

        // Finally see if asset has correct duration
        XCTAssertEqual(sut.audioAsset!.duration.seconds, 3.456, "Sample audio has precisely 3.456s")
    }

    // MARK: - Change Player Status

    func testChangePlayerStatusSuccess() {
        do {
            try sut.changePlayerStatus(for: sampleAudio)
        } catch {
            XCTFail("Should not produce errors")
        }
    }

    func testChangeStatus() {
        sut.changeState(state: State.idle)
        XCTAssertEqual(State.idle, sut.state)

        sut.changeState(state: State.playing(sampleAudio.path))
        XCTAssertEqual(State.playing(sampleAudio.path), sut.state)

        sut.changeState(state: State.paused(sampleAudio.path))
        XCTAssertEqual(State.paused(sampleAudio.path), sut.state)
    }

    // MARK: - Set Up Now Playing

    // 2 Functions were created so swiftLint does not warn for Cyclomatic Complexity Violation

    func testSetupNowPlaying1() {
        sut.createPlayerFrom(file: sampleAudio)
        let infos = sut.setupNowPlaying()

        for element in infos {
            let item = (element.key, element.value)
            self.checkItem(item: item)
        }
    }

    // MARK: - Duration

    func testGetDurationFrom() {
        let duration = sut.getDurationFrom(file: sampleAudio)
        XCTAssertEqual(duration, 3.456, "Sample audio has precisely 3.456s")
    }
}

extension AudioManagerTestsSuccess {

    func checkItem(item: (key: String, value: Any)) {
        switch item.key {
        case MPMediaItemPropertyTitle:
            if let value = item.value as? String,
                let compare = nowPlayingInfos![MPMediaItemPropertyTitle] as? String {
                XCTAssertEqual(value, compare, "Sample audio has title = AudioManagerTest")
            }
        case MPMediaItemPropertyPlaybackDuration:
            if let value = item.value as? Double,
                let compare = nowPlayingInfos![MPMediaItemPropertyPlaybackDuration] as? Double {
                XCTAssertEqual(value, compare, "Sample audio has precisely 3.456s")
            }
        case MPNowPlayingInfoPropertyPlaybackRate:
            if let value = item.value as? Float,
                let compare = nowPlayingInfos![MPNowPlayingInfoPropertyPlaybackRate] as? Float {
                XCTAssertEqual(value, compare, "Sample audio has rate = 0")
            }
        case MPNowPlayingInfoPropertyElapsedPlaybackTime:
        if let value = item.value as? Double,
            let compare = nowPlayingInfos![MPNowPlayingInfoPropertyElapsedPlaybackTime] as? Double {
            XCTAssertEqual(value, compare, "Sample audio has ElapsedPlaybackTime = 0")
        }
        case MPMediaItemPropertyArtwork:
            // Test if object is MPMediaItemArtwork
            XCTAssert(item.value is MPMediaItemArtwork)
        default:
            break
        }
    }
}
