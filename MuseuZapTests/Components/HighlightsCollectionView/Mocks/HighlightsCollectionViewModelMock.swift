//
//  HighlightsCollectionViewModelMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
@testable import Blin

class HighlightsCollectionViewModelMock: HighlightsCollectionViewModelProtocol {

    // Protocol
    weak var delegate: HighlightsCollectionViewModelDelegate?
    weak var tableViewDelegate: HighlightsTableViewCellDelegate?
    var highlightedAudios: [Audio]
    func updateCurrentPage(toPage: Int) {
        isCalled = true
    }

    // Tests
    var isCalled: Bool
    var audiosMock: AudioMock

    init() {
        isCalled = false
        audiosMock = AudioMock()
        highlightedAudios = audiosMock.audioArray
    }

}
