//
//  CustomCellTests.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 28/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import SnapshotTesting
import XCTest
@testable import MuseuZap

class CustomCellSnapshotTests: XCTestCase {
    var customCellView: AudioCell!
    var cellViewController: UIViewController!

    override func setUp() {
        super.setUp()
        
        cellViewController = UIViewController()
        cellViewController.view.backgroundColor = .lightGray
        customCellView = AudioCell(frame: CGRect(x: 0, y: 0, width: 374, height: 76))
        cellViewController.view.addSubview(customCellView)
        customCellView.setupConstraints { (_) in
            customCellView.topAnchor.constraint(equalTo: cellViewController.view.topAnchor, constant: 24).isActive = true
            customCellView.centerXAnchor.constraint(equalTo: cellViewController.view.centerXAnchor).isActive = true
            customCellView.widthAnchor.constraint(equalToConstant: customCellView.frame.width).isActive = true
        }
        record = false
    }

    override func tearDown() {
        customCellView = nil
        cellViewController = nil
        super.tearDown()
    }

    func testSnapshotOneLineTitle() throws {
        let viewModel = PublicAudioCellViewModel.Helper.oneLine
        customCellView?.viewModel = viewModel
        assertSnapshot(matching: cellViewController, as: .image)
    }
    
    func testSnapshotTwoLinesTitle() throws {
        let viewModel = PublicAudioCellViewModel.Helper.twoLines
        customCellView?.viewModel = viewModel
        assertSnapshot(matching: cellViewController, as: .image)
    }
    
    func testSnapshotThreeLinesTitle() throws {
        let viewModel = PublicAudioCellViewModel.Helper.threeLines
        customCellView?.viewModel = viewModel
        assertSnapshot(matching: cellViewController, as: .image)
    }
    
    func testSnapshotFourLinesTitle() throws {
        let viewModel = PublicAudioCellViewModel.Helper.fourLines
        customCellView?.viewModel = viewModel
        assertSnapshot(matching: cellViewController, as: .image)
    }
}
