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
        mockedModel = MockSearchResultsViewModel()
        let cellIdentifier = "test"
        sut = SearchResultsDataSource(viewModel: mockedModel, withIdentifier: cellIdentifier)

        tableView = UITableView()
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = sut

        audioLabel = AudioMock().audioPrivate.audioName
    }

    override func tearDown() {
        sut = nil
        mockedModel = nil
        tableView = nil
        audioLabel = nil
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

    /*
     This test is breaking the constraints when loading custom cell at a isolated tableView, not sure why

    func testAudioLabelText() {

        let table = UITableView()
        let mock = MockSearchResultsViewModel()
        mock.arrayCount = .onePrivate
        table.register(SearchResultsCell.self, forCellReuseIdentifier: "oi")
        let sut1 = SearchResultsDataSource(viewModel: mock, withIdentifier: "oi")
        table.dataSource = sut1

        table.reloadData()
        print(sut1.viewModel.searchResultArray, "\n esse array deve conter APENAS 1 AUDIO")
        print(table.numberOfRows(inSection: 0), "\n aqui mostra que a table view tem APENAS 1 AUDII, O PRIVATE")

        let cell = table.visibleCells[0] as? SearchResultsCell
        print(cell?.titleLabel.text! as Any, "\n e aqui a gente ve que o titulo da celula NAO BATE com o search results array, da AUDIO PUBLIC")

    }
     
   */
}
