//
//  ListViewModelTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
import DatabaseKit
@testable import MuseuZap

// testar count

class ListViewModelTests: XCTestCase {

    var sut: ListViewModel!
    var services: AudioServicesMock!
    var viewDeleg: ListViewModelDelegateMock!
    var audio: Audio!
    var audioProp: AudioProperties!

    override func setUp() {
        services = AudioServicesMock()
        viewDeleg = ListViewModelDelegateMock()
        sut = ListViewModel(audioServices: services, delegate: viewDeleg)

        // Prepare audio
        services.exampleCategory.categoryName = "ListViewModelTests"

        services.exampleAudio.audioName = "Audio 1"
        services.exampleAudio.audioPath = FileManager.default.temporaryDirectory.path
        services.exampleAudio.category = services.exampleCategory
        services.exampleAudio.duration = 15
        services.exampleAudio.isPrivate = true

        audio = services.exampleAudio
        audioProp = AudioProperties(from: audio)
    }

    override func tearDown() {
        services = nil
        viewDeleg = nil
        audio = nil
        audioProp = nil
        sut = nil
    }

    // MARK: - Get Array

    func testGetArray() {
        services.stateCase = .addOneMoreAudio
        
        sut.getArray()

        XCTAssertEqual(sut.array.count, 2, "AudioServicesMock produces one more audio, total 2 audios")
    }

    // MARK: - GetAudioItemProperties

//    func testGetAudioItemProperties() {
//        let indexPath = IndexPath(row: 0, section: 0)
//        var properties = sut.getAudioItemProperties(at: indexPath)
//        properties.duration = 0
//
//        XCTAssertEqual(properties, audioProp)
//    }

}
