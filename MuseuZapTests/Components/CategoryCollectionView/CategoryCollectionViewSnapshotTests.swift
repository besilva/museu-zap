//
//  CategoryCollectionViewSnapshotTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import SnapshotTesting
import XCTest
@testable import MuseuZap
@testable import DatabaseKit

class CategoryCollectionViewSnapshotTests: XCTestCase {
    
    var sut: CategoryCollectionView!
    
    override func setUp() {
        super.setUp()
        record = false
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.0
        layout.scrollDirection = .horizontal
        sut = CategoryCollectionView(frame: CGRect(x: 0, y: 0, width: IPhoneWidths.regular.rawValue, height: 194), collectionViewLayout: layout)
        let viewModel = CategoryCollectionViewModel(service: AudioCategoryServicesMock())
        sut.viewModel = viewModel
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testSnapshot() throws {
       assertSnapshot(matching: sut, as: .image)
    }
 
}
