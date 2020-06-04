//
//  SectionsHeaderViewTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class SectionsHeaderViewTests: XCTestCase {

    var sut: SectionsHeaderView!

    override func setUp() {
        sut = SectionsHeaderView()
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Label

//    func testTitleLabel() {
//        XCTAssertNotNil(sut.titleLabel)
//        XCTAssertEqual(sut.titleLabel.textColor, UIColor.Default.label)
//    }

    // MARK: - Button

    func testButtonLabelText() {
        XCTAssertEqual(sut.seeAllButton.titleLabel?.text, "Ver todos")
    }

    func testButtonLabelColor() {
        XCTAssertEqual(sut.seeAllButton.titleLabel?.textColor, UIColor.Default.power)
    }
}
