//
//  ListViewModelTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
import DatabaseKit
@testable import MuseuZap

class ListViewModelTests: XCTestCase {

    var sut: ListViewModel!
    var audServices: AudioServicesMock!
    var audCatServices: AudioCategoryServicesMock!
    var viewDeleg: ListViewModelDelegateMock!
    var audioPrivate: AudioProperties!
    var searchAudioProp: AudioProperties!

    override func setUp() {
        audServices = AudioServicesMock()
        audCatServices = AudioCategoryServicesMock()
        viewDeleg = ListViewModelDelegateMock()
        sut = ListViewModel(audioServices: audServices, audioCategoryServices: audCatServices, delegate: viewDeleg)

        audioPrivate = AudioProperties(from: audServices.audios.audioPrivate)
        searchAudioProp = AudioProperties(from: audServices.audios.searchAudio)
    }

    override func tearDown() {
        audServices = nil
        audCatServices = nil
        viewDeleg = nil
        audioPrivate = nil
        searchAudioProp = nil
        sut = nil
    }

    // MARK: - Get Array

    func testGetArray() {
        audServices.stateCase = .onlyOneAudio
        
        sut.retrieveAllAudios()
        XCTAssertEqual(sut.audios.count, 1, "AudioaudServicesMock at onlyOneAudio produces only one audio, default 2 (setUp)")
    }

    // MARK: - GetAudioItemProperties

    func testGetAudioItemPropertiesFilteringFalse() {
        // First audio from array created by AudioaudServicesMock is type MockAudio().audioPrivate
        let indexPath = IndexPath(row: 0, section: 0)
        let properties = sut.getAudioItemProperties(at: indexPath)

        XCTAssert(properties == audioPrivate)
    }

    func testGetAudioItemPropertiesWithFilteringTrue() {
        // There is one audio with name "Search"
        sut.performSearch(with: "s")
        viewDeleg.isFiltering = true

        // GetAudioProperties should return properties from searchResultArray, which should contain only "Search" Audio
        let indexPath = IndexPath(row: 0, section: 0)
        let properties = sut.getAudioItemProperties(at: indexPath)

        XCTAssert(properties == searchAudioProp)
    }

    // MARK: - PerformSearch

    func testPerformSearch() {
        // There are 3 audios, only one audio with name "Search"
        sut.performSearch(with: "s")
        XCTAssertEqual(sut.searchResultsArray.count, 1, "AudioaudServicesMock has only one audio with 's' at name")

        let result = sut.searchResultsArray[0]
        XCTAssertEqual(result.audioName, "Search", "AudioaudServicesMock has only one audio with 's' at name")
    }

     // MARK: - Refresh

    func testHandleRefresh() {
        sut.handleRefresh()
        XCTAssert(viewDeleg.refreshFlag)
    }

}
