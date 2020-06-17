//
//  HighlightsCollectionViewTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Blin

class HighlightsCollectionViewTests: XCTestCase {

    var sut: HighlightsCollectionView!
    var viewModelMock: HighlightsCollectionViewModelMock!
    var frame: CGRect!
    var layout: UICollectionViewFlowLayout!
    var index: IndexPath!

    override func setUp() {
        super.setUp()

        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        // This frame will be used to calculate testUpdateCurrentPage
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        sut = HighlightsCollectionView(frame: frame, collectionViewLayout: layout)

        viewModelMock = HighlightsCollectionViewModelMock()
        sut.viewModel = viewModelMock

        index = IndexPath(row: 0, section: 0)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        viewModelMock = nil
        frame = nil
        layout = nil
        index = nil
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
        sut.viewModel = viewModelMock
        XCTAssertEqual(sut.numberOfItems(inSection: 0), 4)
    }

    // Test if cell is HighlightsCell, and test if model is the correct one
    // ViewModelMock at indexPath row 0 should load audioPublic from AudioMock()
    func testCellForItemAt() {

        let cell = sut.collectionView(sut, cellForItemAt: index)

        guard let highlightCell = cell as? HighlightsCell else {
            XCTFail("Should be type HighlightsCell")
            return
        }

        XCTAssertEqual(highlightCell.viewModel?.audio.audioName, AudioMock().audioPublic.audioName)
    }

    // Test if CollectionView occupies the entire HighlightsCollectionView
    func testSize() {
        let size = sut.collectionView(sut, layout: layout, sizeForItemAt: index)
        XCTAssertEqual(size, frame.size)
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
