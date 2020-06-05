//
//  SearchResultsDataSourceTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class SearchResultsDataSourceTests: XCTestCase {

    var sut: SearchResultsDataSource!
    var tableView: UITableView!
    var audioLabel: String!
    var mockedModel: MockSearchResultsViewModel!

    override func setUp() {
        super.setUp()
        mockedModel = MockSearchResultsViewModel()
        let cellIdentifier = "test"
        sut = SearchResultsDataSource(viewModel: mockedModel, withIdentifier: cellIdentifier)

        // Passing a frame to the view will avoid breaking contraints
        tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = sut

        audioLabel = AudioMock().audioPrivate.audioName
    }

    override func tearDown() {
        sut = nil
        mockedModel = nil
        tableView = nil
        audioLabel = nil
        super.tearDown()
    }

    // MARK: - Sections

    func testNumberOfSections() {
        XCTAssertEqual(1, tableView.numberOfSections, "SearchResults should contain only 1 section")
    }

    // MARK: - Rows

    func testNumberOfRows() {
        XCTAssertEqual(3, tableView.numberOfRows(inSection: 0), "MockSearchResultsViewModel produces 3 audios at searchResultArray")
    }

    // MARK: - Label

    func testAudioLabelText() {
        // Assert that searchResultsArray contains one audio
        mockedModel.arrayCount = .onePrivate

        tableView.reloadData()

        let cell = tableView.visibleCells[0] as? SearchResultsCell

        XCTAssertEqual(cell?.titleLabel.text!, audioLabel, "Cell should contain only audioPrivate from MockSearchResultsViewModel")
    }

}
