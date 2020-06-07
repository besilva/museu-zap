//
//  CategoryCollectionViewTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Blin

class CategoryCollectionViewModelTests: XCTestCase {

    var sut: CategoryCollectionViewModel!

    override func setUp() {
        super.setUp()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.0
        layout.scrollDirection = .horizontal
        sut = CategoryCollectionViewModel(service: AudioCategoryServicesMock())
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCategories() {
        XCTAssertEqual(sut.categories.count, 2)
        XCTAssertEqual(sut.categories[0].categoryName,
                       "Engraçados")
        XCTAssertEqual(sut.categories[1].categoryName,
        "Clássicos do Zap")
    }
    
}
