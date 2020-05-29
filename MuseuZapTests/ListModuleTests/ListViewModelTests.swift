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
    var services: AudioServicesMock!
    var viewDeleg: ListViewModelDelegateMock!
    var audioPrivate: AudioProperties!
    var searchAudioProp: AudioProperties!

    override func setUp() {
        services = AudioServicesMock()
        viewDeleg = ListViewModelDelegateMock()
        sut = ListViewModel(audioServices: services, delegate: viewDeleg)

        audioPrivate = AudioProperties(from: services.audios.audioPrivate)
        searchAudioProp = AudioProperties(from: services.audios.searchAudio)
    }

    override func tearDown() {
        services = nil
        viewDeleg = nil
        audioPrivate = nil
        searchAudioProp = nil
        sut = nil
    }

    // MARK: - Get Array

    func testGetArray() {
        services.stateCase = .onlyOneAudio
        
        sut.getArray()

        XCTAssertEqual(sut.array.count, 1, "AudioServicesMock at onlyOneAudio produces only one audio, default 3 (setUp)")
    }

    // MARK: - GetAudioItemProperties

    func testGetAudioItemPropertiesFilteringFalse() {
        // First audio from array created by AudioServicesMock is type MockAudio().audioPrivate
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
        XCTAssertEqual(sut.searchResultsArray.count, 1, "AudioServicesMock has only one audio with 's' at name")

        let result = sut.searchResultsArray[0]
        XCTAssertEqual(result.audioName, "Search", "AudioServicesMock has only one audio with 's' at name")
    }

     // MARK: - Refresh

    func testHandleRefresh() {
        sut.handleRefresh()
        XCTAssert(viewDeleg.refreshFlag)
    }

}
