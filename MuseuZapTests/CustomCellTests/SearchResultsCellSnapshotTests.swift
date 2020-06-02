//
//  SearchResultsCellSnapshotTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import SnapshotTesting
import XCTest
@testable import MuseuZap

class SearchResultsCellSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()
        record = false
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSnapshotOneLineTitle() throws {
        let container = TableViewCellSnapshotContainer<SearchResultsCell>(width: IPhoneWidths.regular.rawValue,
                                                                          configureCell: { cell in
            let viewModel = AudioCellViewModel.Helper.oneLine
            cell.viewModel = viewModel
        })
        assertSnapshot(matching: container, as: .image)
    }

    func testSnapshotTwoLinesTitle() throws {
        let container = TableViewCellSnapshotContainer<SearchResultsCell>(width: IPhoneWidths.regular.rawValue,
                                                                          configureCell: { cell in
            let viewModel = AudioCellViewModel.Helper.twoLines
            cell.viewModel = viewModel
        })
        assertSnapshot(matching: container, as: .image)
    }

    func testSnapshotThreeLinesTitle() throws {
        let container = TableViewCellSnapshotContainer<SearchResultsCell>(width: IPhoneWidths.regular.rawValue,
                                                                          configureCell: { cell in
            let viewModel = AudioCellViewModel.Helper.threeLines
            cell.viewModel = viewModel
        })
        assertSnapshot(matching: container, as: .image)
    }

    func testSnapshotFourLinesTitle() throws {
        let container = TableViewCellSnapshotContainer<SearchResultsCell>(width: IPhoneWidths.regular.rawValue,
                                                                  configureCell: { cell in
            let viewModel = AudioCellViewModel.Helper.fourLines
            cell.viewModel = viewModel
        })
        assertSnapshot(matching: container, as: .image)
    }
}
