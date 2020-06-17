//
//  StackTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Blin

class StackTests: XCTestCase {
    
    var sut: Stack<Int>!

    override func setUp() {
        sut = Stack<Int>()
    }

    override func tearDown() {
        sut = nil
    }

    func testPush() throws {
        sut.push(1)
        XCTAssertEqual(sut.peek(), 1)
    }
    
    func testPop() {
        sut.push(1)
        let poppedNumber = sut.pop()
        XCTAssertEqual(poppedNumber, 1)
        XCTAssertNil(sut.peek())
    }
    
    func testPushMultiple() {
        sut.push(1, 2, 3)
        XCTAssertEqual(sut.peek(), 3)
        _ = sut.pop()
        XCTAssertEqual(sut.peek(), 2)
    }

}
