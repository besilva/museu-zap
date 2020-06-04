//
//  HighlightsCollectionViewTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class HighlightsCollectionViewTests: XCTestCase {

    var sut: HighlightsCollectionView!
    var viewModelMock: HighlightsCollectionViewModelMock!

    override func setUp() {
        super.setUp()

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        // This frame will be used to calculate testUpdateCurrentPage
        let frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        sut = HighlightsCollectionView(frame: frame, collectionViewLayout: layout)

        viewModelMock = HighlightsCollectionViewModelMock()

        sut.viewModel = viewModelMock
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Configuration

    func testConfiguration() {
        XCTAssert(sut.isPagingEnabled)
        XCTAssertFalse(sut.showsVerticalScrollIndicator)
        XCTAssertFalse(sut.showsHorizontalScrollIndicator)
    }

    // MARK: - Collection

    func testNumberOfSections() {
        XCTAssertEqual(sut.numberOfSections, 1)
    }

    // ViewModelMock highlightedAudios has exactly 4 audios, so result should be 4
    func testNumberOfItems() {
         XCTAssertEqual(sut.numberOfItems(inSection: 0), 4)
    }

    // MARK: - Update page

    func testUpdateCurrentPage() {
        var point = CGPoint(x: 5.0, y: 5.0)
        let p = withUnsafeMutablePointer(to: &point) { (p) -> UnsafeMutablePointer<CGPoint> in
            return p
        }

        sut.scrollViewWillEndDragging(sut, withVelocity: CGPoint(x: 0.9, y: 0), targetContentOffset: p)

        XCTAssert(viewModelMock.isCalled)
    }

}
