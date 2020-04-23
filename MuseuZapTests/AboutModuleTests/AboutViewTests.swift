//
//  AboutViewTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 20/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class MockAboutViewModel: AboutViewModel {
    init() {
        super.init(email: "mock@email.com", description: "mocked description")
    }
    
    required init(email: String, description: String) {
        fatalError("init(email:description:) has not been implemented")
    }
}

class MockAboutViewModelDelegate: AboutViewModel {
    override func sendEmail() throws {
        return
    }
}

class AboutViewTests: XCTestCase {
    var aboutView: AboutView?
    var aboutViewModel: MockAboutViewModel?

    override func setUpWithError() throws {
        aboutView = AboutView(frame: CGRect.zero)
        aboutViewModel = MockAboutViewModel()
        aboutView!.viewModel = aboutViewModel
    }

    override func tearDownWithError() throws {
        aboutView = nil
        aboutViewModel = nil
    }

    func testBackgroundColor() throws {
        XCTAssertEqual(self.aboutView?.contentView.backgroundColor, UIColor.Default.background)
    }

    func testLabelColor() throws {
        XCTAssertEqual(self.aboutView?.mailLabel.tintColor, UIColor.Default.label)
    }
    
    func testHandleTap() throws {
        XCTAssertNotNil(aboutView)
        XCTAssertNotNil(aboutView)
        XCTAssertNoThrow(try aboutView?.handleTap())
    }
    
    func testHandleTapFail() throws {
        aboutView?.viewModel = nil
        XCTAssertThrowsError(try aboutView?.handleTap())
    }
}
