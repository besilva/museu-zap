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
    weak var navigationDelegate: NavigationDelegate?
    
    var title: String
    
    var audioPath: String
    
    var duration: TimeInterval
    
    var playing: Bool
    
    var actionHandler: (Action) -> Void
    
    var throwError: Bool = false
    var shareTouch: Bool = false
    var delayTime = 0.0

    func changePlayStatus(completion: ((Error?) -> Void)?) {
//        Sends handler a play action, containing current audio path
        actionHandler(.play(audioPath, { _ in
    //            If play action occurred successfully, changes play status and
    //            Calls completion with no errors
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delayTime) {
                if self.throwError == false {
                    
                    self.playing = !self.playing
                    if let completion = completion {
                        completion(nil)
                    }
                } else {
    //                Calls completion with an error otherwise
                    let mockError = AudioCellError.ShareError
                    
                    if let completion = completion {
                        completion(mockError)
                    }
                }
            }
        }))
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
        
        customCellView?.viewModel = mockViewModel
    }

    override func tearDownWithError() throws {
        mockViewModel = nil
        customCellView = nil
    }

//    func testPlayAudioIcon() throws {
//        
//        let operation = AsyncOperation { self.customCellView.changePlayStatus() }
//        try await(operation.perform)
//        XCTAssertEqual(self.customCellView.playIcon.image, UIImage(named: "pause.fill"), "Output image does not match")
//    }
    
//    func testPlayAudioIconWithDelay() throws {
//        mockViewModel.delayTime = 1.0
//        customCellView?.changePlayStatus()
//        waitForExpectations(timeout: 5.0) { (error) in
//            if let error = error {
//                XCTFail("Did not satisfy every expectation: " + error.localizedDescription)
//            } else {
//                XCTAssertEqual(self.customCellView.playIcon.image, UIImage(named: "pause.fill"))
//            }
//        }
//    }
//    
//    func testPlayAudioIconWithError() throws {
//        mockViewModel.throwError = true
//        customCellView?.changePlayStatus()
//        waitForExpectations(timeout: 5.0) { (error) in
//            if let error = error {
//                XCTFail("Did not satisfy every expectation: " + error.localizedDescription)
//            } else {
//                XCTAssertEqual(self.customCellView.playIcon.image, UIImage(named: "play.fill"))
//            }
//        }
//    }
//    
//    func testPlayAudioIconWithErrorAndDelay() throws {
//        mockViewModel.throwError = true
//        mockViewModel.delayTime = 1.0
//        customCellView?.changePlayStatus()
//        waitForExpectations(timeout: 5.0) { (error) in
//            if let error = error {
//                XCTFail("Did not satisfy every expectation: " + error.localizedDescription)
//            } else {
//                XCTAssertEqual(self.customCellView.playIcon.image, UIImage(named: "play.fill"))
//            }
//        }
//    }

    func testShare() throws {
        customCellView?.shareAudio()
        XCTAssertTrue(mockViewModel.shareTouch)
    }
}
