//
//  HighlightsCollectionViewTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class HighlightsCollectionViewModelTests: XCTestCase {

    var sut: HighlightsCollectionViewModel!
    var audioMock: AudioMock!
    var tableDelegateMock: HighlightsTableViewCellDelegateMock!

    override func setUp() {
        super.setUp()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        sut = HighlightsCollectionViewModel(service: AudioServicesMock())

        tableDelegateMock = HighlightsTableViewCellDelegateMock()
        sut.tableViewDelegate = tableDelegateMock

        audioMock = AudioMock()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        tableDelegateMock = nil
        audioMock = nil
    }

    // MARK: - Table Delegate

    // Assert that delegate is called and page number is correct
    func testUpdateCurrentPage() {
        sut.updateCurrentPage(toPage: 3)
        XCTAssert(tableDelegateMock.isCalled)
    }

    // MARK: - Filter

    // Give FilterHighlights all audios from audioMock, result should be only one
    func testFilterHighlights() {

        let result = sut.filterHighlights(array: audioMock.audioArray)

        XCTAssertEqual(result.count, 1, "result should be only one, highlightAudio from audioMock")
        XCTAssertEqual(result[0].audioName, "Seu Armando", "result should be highlightAudio from audioMock")
    }

}
