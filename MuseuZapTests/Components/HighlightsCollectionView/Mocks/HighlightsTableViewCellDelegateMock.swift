//
//  HighlightsTableViewCellDelegateMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

@testable import MuseuZap

class HighlightsTableViewCellDelegateMock: HighlightsTableViewCellDelegate {
    public var isCalled: Bool = false

    func updatePageControlToPage(toPage: Int) {
        isCalled = true
    }

}
