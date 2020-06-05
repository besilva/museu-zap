//
//  SearchResultsViewControllerTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class SearchResultsViewControllerTests: XCTestCase {

    // Note: Here are also parts from SearchResultsView tested, embedded

    var sut: SearchResultsViewController!

    override func setUp() {
        super.setUp()
        sut = SearchResultsViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Load View

    func testViewAsSearchResultsView() {

        // Calls view life Cycle
        _ = sut.view

        XCTAssert(sut.view is SearchResultsView)
    }

    // MARK: - View Did Load

    func testViewDidLoadCreateDelegates() {

        // Calls view life Cycle
        _ = sut.view

        XCTAssertNotNil(sut.model)
        XCTAssertNotNil(sut.viewDelegate)
    }
}
