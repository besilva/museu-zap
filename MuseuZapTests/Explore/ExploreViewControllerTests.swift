//
//  ExploreViewControllerTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class ExploreViewControllerMock: ExploreViewController {
    func setScreenName(analytics: AnalyticsProtocol = FirebaseAnalytics.shared) -> Bool {
        return true
    }
}

class ExploreViewControllerTests: XCTestCase {

    var sut: ExploreViewControllerMock!
    var navigation: UINavigationController!

    override func setUp() {
        sut = ExploreViewControllerMock()
        navigation = UINavigationController()
        navigation.pushViewController(sut, animated: false)
    }
    
    override func tearDown() {
        sut = nil
        navigation = nil
    }
    
    func testView() {
        XCTAssert(sut.view is ExploreView)
    }
    
    func testSetScreenName() {
        XCTAssert(sut.setScreenName())
        XCTAssertEqual(sut.screenName, "Início Destaques")
    }
}
