//
//  MuseuZapTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class TestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllWordsLoaded() {
        let data = Playdata()
        XCTAssertEqual(data.words.count, 0, "must be -")
    }

}
