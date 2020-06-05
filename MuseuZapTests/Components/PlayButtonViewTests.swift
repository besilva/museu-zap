//
//  PlayButtonViewTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

/* Views should be tested for:

 Is the number of table view rows correct?
 Is UILabel text correct?
 Is the button enabled?
 Is UIView frame correct?
 
 */

class PlayButtonViewTests: XCTestCase {

    var sut: PlayButtonView!

    override func setUp() {
        super.setUp()
        sut = PlayButtonView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - View Contraints

    // Should test view frame size, but it is always 0
    // Should initialize view with a frame somehow

    func testViewConstraints() {

        for constraint in sut.constraints {
            switch constraint.firstAttribute.rawValue {
            case 7, 8: // Width or Height
                XCTAssertEqual(constraint.constant, 44)
                print(constraint)
            default:
                continue
            }
        }

    }

    // MARK: - Icon

    func testViewIcon() {
        XCTAssertEqual(sut.icon.image, UIImage.Default.playIcon)
    }
}
