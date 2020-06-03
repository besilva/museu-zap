//
//  UIViewControllerExtensionTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class ViewControllerMock: AboutViewController {
    override var screenName: String { return "teste"}
    
    func setScreenName(analytics: AnalyticsProtocol = FirebaseAnalytics.shared) -> Bool {
        return true
    }
}

class UIViewControllerExtensionTests: XCTestCase {
    
    var sut: ViewController!
    var navigation: UINavigationController!

    override func setUp() {
        sut = ViewControllerMock()
        navigation = UINavigationController()
        navigation.pushViewController(sut, animated: false)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        navigation = nil
    }
    
    func testScreenName() {
        XCTAssertEqual(sut.screenName, "teste")
    }
    
    func testAnalytics() {
        XCTAssert(sut.setScreenName())
    }
    
    func testNavBarHeight() {
        XCTAssertEqual(sut.navBarHeight, 64)
    }

}
