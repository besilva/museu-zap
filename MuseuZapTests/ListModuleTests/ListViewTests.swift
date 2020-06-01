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
@testable import MuseuZap

class ListViewModelMock: ListViewModelProtocol {
    var audioServices: AudioServicesProtocol
    
    var searchResultArray: [Audio] = []
    
    var audios: [Audio] = []
    
    weak var navigationDelegate: NavigationDelegate?
    
    var count: Int {
        if delegate?.isFiltering ?? false {
            return searchResultArray.count
        }
        return audios.count
    }
    
    weak var delegate: ListViewModelDelegate?

    func handleRefresh() {
    }
    
    func performSearch(with text: String) {
    }
    
    required init(audioServices: AudioServicesProtocol, delegate: ListViewModelDelegate) {
        self.audioServices = audioServices
        self.delegate = delegate
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        return
    }
    
    func back() {
        return
    }
}

class ListViewTests: XCTestCase {
    var listView: ListView!
    var listViewModel: ListViewModelProtocol!

    override func setUpWithError() throws {
        listView = ListView(frame: CGRect.zero)
        let dummyServices = AudioServices()
        listViewModel = ListViewModelMock(audioServices: dummyServices, delegate: listView)
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
