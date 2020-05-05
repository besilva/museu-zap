//
//  CustomCellTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 28/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class AudioCellViewModelMock: AudioCellViewModelProtocol {
    var navigationDelegate: NavigationDelegate?
    
    var title: String
    
    var audioURL: String
    
    var duration: TimeInterval
    
    var playing: Bool
    
    var shareTouch: Bool

    func changePlayStatus() {
        playing = true
    }
    
    func share() {
        shareTouch = true
    }
    
    required init(title: String, duration: TimeInterval, audioURL: String) {
        self.title = title
        self.duration = duration
        self.audioURL = audioURL
        self.playing = false
        self.shareTouch = false
    }
    
    required init(audioURL: String) {
        self.audioURL = audioURL
        self.playing = false
        self.shareTouch = false
        // TODO: Call to API function to retrieve audio data
        self.title = "Lorem Ipsum"
        self.duration = 60
    }
}

class CustomCellTests: XCTestCase {
    var customCellView: AudioCell!
    var mockViewModel: AudioCellViewModelMock!
    
    override func setUpWithError() throws {
        super.setUp()
        customCellView = AudioCell()
        mockViewModel = AudioCellViewModelMock(title: "gemidao", duration: 90, audioURL: "sampleURL")
        customCellView?.viewModel = mockViewModel
    }

    override func tearDownWithError() throws {
        mockViewModel = nil
        customCellView = nil
    }

    func testPlayAudio() throws {
        customCellView?.changePlayStatus()
        XCTAssertTrue(mockViewModel.playing)
        XCTAssertEqual(customCellView.playIcon.image, UIImage(named: "pause.fill"))
    }
    
    func testShare() throws {
        customCellView?.shareAudio()
        XCTAssertTrue(mockViewModel.shareTouch)
    }
}
