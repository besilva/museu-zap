//
//  ListViewTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
import UIKit
import DatabaseKit
@testable import Blin

class ListViewModelMock: ListViewModelProtocol {
    var audios: [Audio] = []
    var audioServices: AudioServicesProtocol
    var audioCategories: [AudioCategory] = []
    var audioCategoryServices: AudioCategoryServicesProtocol
    var searchResultsArray: [Audio] = []
    var searchManager: SearchResultsViewController
    var count: Int {
        if delegate?.isFiltering ?? false {
            return searchResultsArray.count
        }
        return audios.count
    }
    weak var navigationDelegate: NavigationDelegate?
    weak var delegate: ListViewModelDelegate?

    func handleRefresh() {
    }

    func performSearch(with text: String) {
    }

    func back() {
    }

    required init(audioServices: AudioServicesProtocol, audioCategoryServices: AudioCategoryServicesProtocol, delegate: ListViewModelDelegate) {
        self.audioServices = audioServices
        self.audioCategoryServices = audioCategoryServices
        self.delegate = delegate
        self.searchResultsArray = []
        self.searchManager = SearchResultsViewController()
    }
}

class ListViewTests: XCTestCase {
    var listView: ListView!
    var listViewModel: ListViewModelProtocol!

    override func setUpWithError() throws {
        listView = ListView(frame: CGRect.zero)
        let dummyServices1 = AudioServices()
        let dummyServices2 = AudioCategoryServices()
        listViewModel = ListViewModelMock(audioServices: dummyServices1, audioCategoryServices: dummyServices2, delegate: listView)
        listView.viewModel = listViewModel
    }

    override func tearDownWithError() throws {
        listView = nil
        listViewModel = nil
    }

    func testPlaceholderViewIsNotHidden() throws {
        // No data was loaded, so placeholderView is showed
        listView.reloadTableView()
        XCTAssertFalse(listView.placeholderView.isHidden)
    }
    
    func testPlaceholderViewIsHidden() throws {
        // Data was loaded, so placeholderView is hidden
        let newAudio = Audio()
        listView.viewModel?.audios.append(newAudio)
        listView.reloadTableView()
        XCTAssertTrue(listView.placeholderView.isHidden)
    }
}
