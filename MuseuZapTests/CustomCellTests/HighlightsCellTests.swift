//
//  HighlightsCellTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
import XCTest
@testable import MuseuZap

class HighlightsCellViewModelMock: HighlightsCellViewModelProtocol {
    // Protocol
    var audio: Audio
    var image: UIImage
    func changePlayStatus(cell: HighlightsCell) {
        isCalled = true
    }

    // Test
    var isCalled: Bool
    init() {
        audio = AudioMock().audioPublic
        image = UIImage()
        isCalled = false
    }

}

class HighlightsCellTests: XCTestCase {

    var sut: HighlightsCell!
    var viewModelMock: HighlightsCellViewModelMock!

    override func setUp() {
        super.setUp()
        sut = HighlightsCell()
        viewModelMock = HighlightsCellViewModelMock()
        sut.viewModel = viewModelMock
    }

    override func tearDown() {
        sut = nil
        viewModelMock = nil
        super.tearDown()
    }

    // MARK: - Icon

    func testViewIcon() {
        XCTAssertEqual(sut.playButton.icon.image, UIImage.Default.playIconHighlights)
    }

    // MARK: - isPlaying

    func testIsPlaying() {
        sut.isPlaying = true
        XCTAssertEqual(sut.playButton.icon.image, sut.pauseImage)
        sut.isPlaying = false
        XCTAssertEqual(sut.playButton.icon.image, sut.playImage)
    }

     // MARK: - Button action

    func testButton() {
        XCTAssert(sut.responds(to: #selector(HighlightsCell.changePlayStatus)))

    }

    // MARK: - Change Status

    func testChangeIcon() {
        sut.changePlayStatus()
        XCTAssert(viewModelMock.isCalled)
    }

}
