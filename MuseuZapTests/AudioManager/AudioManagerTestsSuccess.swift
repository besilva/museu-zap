//
//  AudioManagerTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 13/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class AudioManagerTestsSuccess: XCTestCase {

    var sut: AudioManager!
    var sampleAudio: URL!

    override func setUp() {
        sut = AudioManager(notificationCenter: MockedNotificationCenter())

        // Sample Audio has to be target to main Application
        let path = Bundle.main.path(forResource: "AudioManagerTest", ofType: "m4a")!
        sampleAudio = URL(fileURLWithPath: path, isDirectory: false)
    }

    override func tearDown() {
        // Since singleton will be used, just set all the properties back to nil
        sut = AudioManager()
        sampleAudio = nil
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

    // MARK: - Duration

    func testGetDurationFrom() {
        let duration = sut.getDurationFrom(file: sampleAudio)
        XCTAssertEqual(duration, 3.456, "Sample audio has precisely 3.456s")
    }
}
