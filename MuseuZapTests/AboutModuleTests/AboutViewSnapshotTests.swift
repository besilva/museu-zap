//
//  AboutViewSnapshotTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 06/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import XCTest
import SnapshotTesting
@testable import MuseuZap

class AboutViewSnapshotTests: XCTestCase {
    var aboutView: AboutView!
    var aboutViewModel: MockAboutViewModel!

    override func setUpWithError() throws {
        aboutView = AboutView(frame: CGRect.zero)
        aboutViewModel = MockAboutViewModel()
        aboutView.viewModel = aboutViewModel
        record = false
    }

    override func tearDownWithError() throws {
        aboutView = nil
        aboutViewModel = nil
        UIPasteboard.general.string = ""
    }

    func testStandardLayout() throws {
        let container = SnapshotContainer<UIView>(aboutView, width: IPhoneWidths.regular.rawValue)
        assertSnapshot(matching: container, as: .image)
    }
}
