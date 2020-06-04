//
//  ExploreViewTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class ExploreViewTests: XCTestCase {

    var sut: ExploreView!
    
    override func setUp() {
        super.setUp()
        sut = ExploreView(frame: CGRect(x: 0, y: 0, width: IPhoneWidths.regular.rawValue, height: 1000))
        let audioServices = AudioServicesMock()
        let audioCategoryServices = AudioCategoryServicesMock()
        let viewDeleg = ListViewModelDelegateMock()
        sut.viewModel = ListViewModel(audioServices: audioServices, audioCategoryServices: audioCategoryServices, delegate: viewDeleg)

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetupTableView() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func testDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        let sections: Int = sut.tableView.dataSource?.numberOfSections?(in: sut.tableView) ?? 0
        XCTAssertEqual(sections, 2)
    }
    
    func testFirstCell() {
        XCTAssertNotNil(sut.tableView.visibleCells.first)
        XCTAssert(sut.tableView.visibleCells.first is PublicCategoryTableViewCell)
    }
    
    func testSecondCell() {
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertNotNil(cell)
        XCTAssert(cell is AudioCell)
    }

}
