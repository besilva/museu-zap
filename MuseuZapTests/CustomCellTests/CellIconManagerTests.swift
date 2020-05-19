//
//  CellIconManagerTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 15/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class CellIconManagerTests: XCTestCase {
    var cellIconManager: CellIconManager!
    var mockedCell: AudioCell!
    var mockedViewModel: MockAudioCellViewModel!
    var notificationCenter: NotificationCenter!
    
    override func setUpWithError() throws {
        super.setUp()
        cellIconManager = CellIconManager.shared
        notificationCenter = AudioManager.shared.notificationCenter
        mockedCell = AudioCell(frame: CGRect.zero)
        mockedViewModel = MockAudioCellViewModel(title: "gemidao", duration: 90, audioPath: "sampleURL") { action in
            switch action {
            case .play(_, let completion):
                completion(nil)
            case .share:
                return
            default:
                return
            }
        }
        mockedCell.viewModel = mockedViewModel
        
    }

    override func tearDownWithError() throws {
        cellIconManager = nil
        mockedCell = nil
        mockedViewModel = nil
    }

    // Tests if posting a playback start triggers a notification
    func testPlaybackStarted() throws {
        notificationCenter.post(name: .playbackStarted, object: mockedCell.viewModel?.audioPath)
        XCTAssertEqual(cellIconManager.playStatus, State.playing(mockedViewModel.audioPath))
    }
    
    // Tests if posting a playback pause triggers a notification
    func testPlaybackPaused() throws {
        notificationCenter.post(name: .playbackPaused, object: mockedCell.viewModel?.audioPath)
        XCTAssertEqual(cellIconManager.playStatus, State.paused(mockedViewModel.audioPath))
    }
    
    // Tests if posting a playback start causes an icon change in the cell
    func testPlaybackStartChangesIcon() throws {
        cellIconManager.subjectCell = mockedCell
        notificationCenter.post(name: .playbackStarted, object: mockedCell.viewModel?.audioPath)
        XCTAssertEqual(cellIconManager.playStatus, State.playing(mockedViewModel.audioPath))
        XCTAssertEqual(self.mockedCell.playIcon.image, UIImage(named: "pause.fill"))
    }
    
    // Tests if posting a playback pause after a start causes an icon change in the cell
    func testPlaybackStartPauseChangesIcon() throws {
        cellIconManager.subjectCell = mockedCell
        notificationCenter.post(name: .playbackStarted, object: mockedCell.viewModel?.audioPath)
        notificationCenter.post(name: .playbackPaused, object: mockedCell.viewModel?.audioPath)
        XCTAssertEqual(cellIconManager.playStatus, State.paused(mockedViewModel.audioPath))
        XCTAssertEqual(self.mockedCell.playIcon.image, UIImage(named: "play.fill"))
    }
}
