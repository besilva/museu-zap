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
    var actionHandler: (Action) -> Void
    
    weak var navigationDelegate: NavigationDelegate?
    
    var title: String
    
    var audioPath: String
    
    var duration: TimeInterval
    
    var playing: Bool
    
    var shareTouch: Bool

    func changePlayStatus() {
        playing = true
    }
    
    func share() {
        shareTouch = true
    }
    
    required init(title: String, duration: TimeInterval, audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.title = title
        self.duration = duration
        self.audioPath = audioPath
        self.playing = false
        self.shareTouch = false
        actionHandler = audioHandler
    }
    
    required init(audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.audioPath = audioPath
        self.playing = false
        self.shareTouch = false
        // TODO: Call to API function to retrieve audio data
        self.title = "Lorem Ipsum"
        self.duration = 60
        actionHandler = audioHandler
    }
}

class CustomCellTests: XCTestCase {
    var customCellView: AudioCell!
    var mockViewModel: AudioCellViewModelMock!
    
    override func setUpWithError() throws {
        super.setUp()
        customCellView = AudioCell()
        mockViewModel = AudioCellViewModelMock(title: "gemidao", duration: 90, audioPath: "sampleURL") { _ in
            return
        }
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
