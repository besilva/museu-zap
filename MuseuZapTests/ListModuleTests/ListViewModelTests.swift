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

// testar count

class ListViewModelTests: XCTestCase {

    var sut: ListViewModel!
    var services: AudioServicesMock!
    var viewDeleg: ListViewModelDelegateMock!
    var audioProp: AudioProperties!
    var searchAudioProp: AudioProperties!

    override func setUp() {
        services = AudioServicesMock()
        viewDeleg = ListViewModelDelegateMock()
        sut = ListViewModel(audioServices: services, delegate: viewDeleg)

        audioProp = AudioProperties(from: services.audio1)
        searchAudioProp = AudioProperties(from: services.searchAudio)
    }

    override func tearDown() {
        services = nil
        viewDeleg = nil
        audioProp = nil
        searchAudioProp = nil
        sut = nil
    }

    // MARK: - Get Array

    func testGetArray() {
        services.stateCase = .onlyOneAudio
        
        sut.getArray()

        XCTAssertEqual(sut.array.count, 1, "AudioServicesMock at onlyOneAudio produces only one audio, default 2 (setUp)")
    }

    // MARK: - GetAudioItemProperties

    func testGetAudioItemPropertiesFilteringFalse() {
        // First is audio1
        let indexPath = IndexPath(row: 0, section: 0)
        let properties = sut.getAudioItemProperties(at: indexPath)

        XCTAssert(properties == audioProp)
    }

    func testGetAudioItemPropertiesWithFilteringTrue() {
        // There is one audio with name "Search Audio"
        sut.performSearch(with: "s")
        viewDeleg.isFiltering = true

        // GetAudioProperties should return properties from searchResultArray
        let indexPath = IndexPath(row: 0, section: 0)
        let properties = sut.getAudioItemProperties(at: indexPath)

        XCTAssert(properties == searchAudioProp)
    }

    // MARK: - PerformSearch

    func testPerformSearch() {
        // There is one audio with name "Search Audio"
        sut.performSearch(with: "s")
        XCTAssertEqual(sut.searchResultArray.count, 1, "AudioServicesMock has only one audio with 's' at name")

        let result = sut.searchResultArray[0]
        XCTAssertEqual(result.audioName, "Search Audio", "AudioServicesMock has only one audio with 's' at name")
    }

     // MARK: - Refresh

    func testHandleRefresh() {
        sut.handleRefresh()
        XCTAssert(viewDeleg.refreshFlag)
    }

}
