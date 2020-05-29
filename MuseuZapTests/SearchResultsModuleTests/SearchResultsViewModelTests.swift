//
//  SearchResultsViewModelTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
import DatabaseKit
@testable import MuseuZap

class SearchResultsViewModelTests: XCTestCase {

    var sut: SearchResultsViewModel!
    var audios: MockAudio!
    var audioProp: AudioProperties!

    override func setUp() {
        sut = SearchResultsViewModel()
        audios = MockAudio()

        sut.searchResultArray = [audios.audioPublic]

        audioProp = AudioProperties(from: audios.audioPublic)
    }

    override func tearDown() {
        sut = nil
        audios = nil
        audioProp = nil
    }

    // MARK: - GetSearchedAudioItemProperties

    func testGetSearchedAudioItemProperties() {
        // SearchResultArray has been given the audioPublic
        let indexPath = IndexPath(row: 0, section: 0)
        let properties = sut.getSearchedAudioItemProperties(at: indexPath)

        XCTAssert(properties == audioProp)
    }

}
