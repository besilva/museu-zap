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
    var audioServices: AudioServicesMock!
    var audioCategoryServices: AudioCategoryServicesMock!
    var viewDeleg: ListViewModelDelegateMock!
    var audioPrivate: AudioProperties!
    var searchAudioProp: AudioProperties!
    var index: IndexPath!

    override func setUp() {
        audioServices = AudioServicesMock()
        audioCategoryServices = AudioCategoryServicesMock()
        viewDeleg = ListViewModelDelegateMock()
        sut = ListViewModel(audioServices: audioServices, audioCategoryServices: audioCategoryServices, delegate: viewDeleg)

        audioPrivate = AudioProperties(from: audioServices.audios.audioPrivate)
        searchAudioProp = AudioProperties(from: audioServices.audios.searchAudio)

        index = IndexPath(row: 0, section: 0)
    }

    override func tearDown() {
        audioServices = nil
        audioCategoryServices = nil
        viewDeleg = nil
        audioPrivate = nil
        searchAudioProp = nil
        index = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Get Array

    func testGetArray() {
        
        sut.retrieveAllAudios()
        XCTAssert(audioServices.isCalled)
    }

    // MARK: - GetAudioItemProperties

    func testGetAudioItemPropertiesFilteringFalse() {
        // First audio from array created by AudioaudServicesMock is type MockAudio().audioPrivate

        let properties = sut.getAudioItemProperties(at: index)

        XCTAssert(properties == audioPrivate)
    }

    func testGetAudioItemPropertiesWithFilteringTrue() {
        // There is one audio with name "Search"
        sut.performSearch(with: "s")
        viewDeleg.isFiltering = true

        // GetAudioProperties should return properties from searchResultArray, which should contain only "Search" Audio
        let properties = sut.getAudioItemProperties(at: index)

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
