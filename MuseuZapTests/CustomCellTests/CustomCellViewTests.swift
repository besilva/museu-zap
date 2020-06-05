//
//  CustomCellTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 28/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class MockAudioCellViewModel: AudioCellViewModelProtocol {
    weak var delegate: AudioCellViewModelDelegate?
    
    weak var navigationDelegate: NavigationDelegate?
    
    var title: String
    
    var audioPath: String
    
    var duration: TimeInterval
    
    var playing: Bool
    
    var actionHandler: (Action) -> Void
    
    var iconManager: CellIconManager = CellIconManager()
    var throwError: Bool = false
    var shareTouch: Bool = false
    var delayTime = 0.0

    func changePlayStatus(cell: AudioCell) {
        iconManager.changePlayStatus(audioPath: audioPath, cell: cell)
    }

    func share() {
        self.shareTouch = true
        return
    }
    
    required init(title: String, duration: TimeInterval, audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.title = title
        self.duration = duration
        self.audioPath = audioPath
        self.playing = false
        actionHandler = audioHandler
    }
    
    required init(audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.audioPath = audioPath
        self.playing = false
        self.title = "Lorem Ipsum"
        self.duration = 90
        actionHandler = audioHandler
    }
}

class CustomCellViewTests: XCTestCase {
    var customCellView: AudioCell!
    var mockViewModel: MockAudioCellViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        customCellView = AudioCell()
        mockViewModel = MockAudioCellViewModel(title: "gemidao", duration: 90, audioPath: "sampleURL") { action in
            switch action {
            case .play(_, let completion):
                completion(nil)
            case .share:
                return
            default:
                return
            }
        }
        customCellView.viewModel = mockViewModel
    }

    override func tearDownWithError() throws {
        mockViewModel = nil
        customCellView = nil
    }

    // Tests if changing isPlaying status causes an icon change
    func testPlayAudioIcon() throws {
        self.customCellView.isPlaying = true

        XCTAssertEqual(self.customCellView.playIcon.image, self.customCellView.pauseImage, "Output image does not match")
    }

    func testShare() throws {
        customCellView?.shareAudio()
        XCTAssertTrue(mockViewModel.shareTouch)
    }
}
