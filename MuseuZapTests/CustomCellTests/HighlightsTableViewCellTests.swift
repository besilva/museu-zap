
//
//  HighlightsTableViewCellTestss.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class HighlightsTableViewCellTests: XCTestCase {

    var sut: HighlightsTableViewCell!

    override func setUp() {
        super.setUp()
        sut = HighlightsTableViewCell()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Views

    func testViewsNotNil() {
        XCTAssertNotNil(sut.highlightsCollection)
        XCTAssertNotNil(sut.sectionView)
    }

     // MARK: - Section Label

    func testSectionLabel() {
        XCTAssertEqual(sut.sectionView.sectionLabel.text, "Top áudios")
    }

}
