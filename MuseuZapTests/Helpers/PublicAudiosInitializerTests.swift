//
//  PublicAudiosInitializerTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 07/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Blin

class PublicAudiosInitializerTests: XCTestCase {

    var sut: PublicAudiosInitializer!

    override func setUp() {
        super.setUp()
        sut = PublicAudiosInitializer()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Test array counts

    func testArrayCounts() {

        XCTAssertEqual(sut.funny.count, 10)
        XCTAssertEqual(sut.classic.count, 9)
        XCTAssertEqual(sut.jokes.count, 6)
        XCTAssertEqual(sut.musical.count, 4)
        XCTAssertEqual(sut.friday.count, 4)
        XCTAssertEqual(sut.family.count, 4)
        XCTAssertEqual(sut.pranks.count, 7)
        XCTAssertEqual(sut.quarantine.count, 9)
    }
}
