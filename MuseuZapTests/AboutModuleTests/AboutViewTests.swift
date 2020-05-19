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
        // swiftlint:disable line_length
        let aboutDescription1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi elementum nunc, sollicitudin non pellentesque. In egestas adipiscing vestibulum varius "
        let aboutDescription2 = "urna sed ornare consectetur. Convallis in volutpat fermentum ipsum in condimentum ut. Odio ornare id ornare augue. Aliquam sit cras arcu amet erat maecenas mi, amet."
        // swiftlint:enable line_length
        super.init(email: "mock@email.com", description: aboutDescription1 + aboutDescription2)
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
    var aboutView: AboutView!
    var aboutViewModel: MockAboutViewModel!

    override func setUpWithError() throws {
        aboutView = AboutView(frame: CGRect.zero)
        aboutViewModel = MockAboutViewModel()
        aboutView.viewModel = aboutViewModel
    }

    override func tearDownWithError() throws {
        aboutView = nil
        aboutViewModel = nil
        UIPasteboard.general.string = ""
    }

    func testBackgroundColor() throws {
        XCTAssertEqual(self.aboutView.contentView.backgroundColor, UIColor.Default.background)
    }

    func testLabelColor() throws {
        XCTAssertEqual(self.aboutView.mailLabel.tintColor, UIColor.Default.label)
    }
    
    func testHandleTap() throws {
        XCTAssertNotNil(aboutView)
        XCTAssertNoThrow(try aboutView.handleTap())
    }
    
    func testHandleTapFail() throws {
        aboutView.viewModel = nil
        XCTAssertThrowsError(try aboutView.handleTap())
    }
    
    func testCopy() throws {
        XCTAssertNoThrow(try aboutView.addToClipboard())
        XCTAssertEqual(aboutViewModel.email, UIPasteboard.general.string)
    }
    
    func testCopyFail() throws {
        aboutView.viewModel = nil
        XCTAssertThrowsError(try aboutView.addToClipboard())
    }
}
