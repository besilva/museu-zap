//
//  SearchResultsViewModelTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
import DatabaseKit
@testable import Blin

class SearchResultsViewModelTests: XCTestCase {

    var sut: SearchResultsViewModel!
    var audios: AudioMock!
    var audioProp: AudioProperties!

    override func setUp() {
        super.setUp()
        sut = SearchResultsViewModel()
        audios = AudioMock()

        sut.searchResultArray = [audios.audioPublic]

        audioProp = AudioProperties(from: audios.audioPublic)
    }

    override func tearDown() {
        sut = nil
        audios = nil
        audioProp = nil
        super.tearDown()
    }

    // MARK: - GetSearchedAudioItemProperties

    func testGetSearchedAudioItemProperties() {
        // SearchResultArray has been given the audioPublic
        let indexPath = IndexPath(row: 0, section: 0)
        let properties = sut.getSearchedAudioItemProperties(at: indexPath)

        XCTAssert(properties == audioProp)
    }

}
