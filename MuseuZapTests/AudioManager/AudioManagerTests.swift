//
//  AudioManagerTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 13/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class AudioManagerTests: XCTestCase {

    var sut: AudioManager!

    override func setUp() {
//        sut = AudioManager(notificationCenter: <#T##NotificationCenter#>)

    }

    override func tearDown() {
        // Since singleton will be used, just set all the properties back to nil
        sut.remoteCommandCenter = nil

        sut.audioAsset = nil
        sut.currentAudio = nil

    }

    // MARK: - List

    // MARK: - Copy

}

class MockedNotificationCenter: NotificationCenter {

}
