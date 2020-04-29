//
//  CustomCellTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 28/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import FBSnapshotTestCase
@testable import MuseuZap

class CustomCellSnapshotTests: FBSnapshotTestCase {
    var customCellView: AudioCellView!
    
    override func setUp() {
        super.setUp()
        customCellView = AudioCellView(frame: CGRect(x: 0, y: 0, width: 374, height: 76))
        customCellView.autoresizingMask = [.flexibleHeight]
        recordMode = true
    }


    override func tearDown() {
        customCellView = nil
        super.tearDown()
    }

    func testSnapshotOneLineTitle() throws {
        let viewModel = PublicAudioCellViewModel(title: "gemidao", duration: 90, audioURL: "sampleURL")
        customCellView?.viewModel = viewModel
        FBSnapshotVerifyView(customCellView!)
    }
    
    func testSnapshotTwoLinesTitle() throws {
        let viewModel = PublicAudioCellViewModel(title: "gemidao gemidao gemidao gemidao gemidao", duration: 90, audioURL: "sampleURL")
        customCellView?.viewModel = viewModel
        FBSnapshotVerifyView(customCellView!)
    }
}
