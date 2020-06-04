//
//  AudioManagerTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 13/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class AudioManagerTestsError: XCTestCase {

    var sut: AudioManager!
    var noAudioFile: URL!
    var nonExistingFile: URL!

    override func setUp() {
        super.setUp()
        sut = AudioManager(notificationCenter: MockedNotificationCenter(), nowPlayingInfoCenter: nil)

        // NoAudioFile has to be target to main Application, is a file with the wrong extension
        let path = Bundle.main.path(forResource: "wrongExtension", ofType: "txt")!
        noAudioFile = URL(fileURLWithPath: path, isDirectory: false)

        // NonExistingFile does not exists
        let fileName2 = "NonExistingFile"
        nonExistingFile = FileManager.default.temporaryDirectory.appendingPathComponent(fileName2)
    }

    override func tearDown() {
        super.tearDown()
        // Since singleton will be used, just set all the properties back to nil
        sut = AudioManager()
        noAudioFile = nil
        nonExistingFile = nil
    }

    // MARK: - Change Player Status

    func testChangePlayerStatusError() {

        XCTAssertThrowsError(try sut.changePlayerStatus(for: noAudioFile)) { error in
            XCTAssertEqual(error as? AudioErrors, AudioErrors.noAudioFile)
        }
    }

    // MARK: - Verify If URL Is Audio File

    func testVerifyIfURLIsAudioFileError1() {

        XCTAssertThrowsError(try sut.verifyIfURLIsAudioFile(url: nonExistingFile)) { error in
            XCTAssertEqual(error as? FileErrors, FileErrors.invalidURL)
        }
    }

    func testVerifyIfURLIsAudioFileError2() {

        XCTAssertThrowsError(try sut.verifyIfURLIsAudioFile(url: noAudioFile)) { error in
            XCTAssertEqual(error as? AudioErrors, AudioErrors.noAudioFile)
        }
    }

    // MARK: - Duration

    func testGetDurationFromError() {
        // If file is no Audio, duration should be 0
        let duration = sut.getDurationFrom(file: noAudioFile)
        XCTAssertEqual(duration, 0, "If file is no Audio, duration should be 0")
    }

}
