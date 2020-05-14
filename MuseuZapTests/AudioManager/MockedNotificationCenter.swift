//
//  MockedNotificationCenter.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 14/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class MockedNotificationCenter: NotificationCenter {
    
//     Sample Audio has to be target to main Application
    let path = Bundle.main.path(forResource: "AudioManagerTest", ofType: "m4a")!
    let sampleAudio: URL!

    override init() {
        sampleAudio = URL(fileURLWithPath: path, isDirectory: false)
    }

    // Since we cannot test private properties, we test if the argument was correct
    override func post(name: NSNotification.Name, object: Any?) {
        switch name {
        case .playbackPaused, .playbackStarted:
            XCTAssertEqual(sampleAudio.path, object as? String)
        case .playbackStopped:
            XCTAssertNil(object)
        default:
            break
        }
    }
}
