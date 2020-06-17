//
//  AudioDataViewTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Blin

class AudioDataViewTests: XCTestCase {

    var sut: AudioDataView!

    override func setUp() {
        super.setUp()
        sut = AudioDataView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Labels

    func testTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertEqual(sut.titleLabel.textColor, UIColor.Default.label)
    }

    func testNumberOfLines() {
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
    }

    func testDurationLabel() {
        XCTAssertNotNil(sut.durationLabel)
        XCTAssertEqual(sut.durationLabel.textColor, UIColor.Default.lightLabel)
    }

    func testAlignment() {
        XCTAssertEqual(sut.titleLabel.textAlignment, NSTextAlignment.left)
        XCTAssertEqual(sut.durationLabel.textAlignment, NSTextAlignment.left)
    }
}
