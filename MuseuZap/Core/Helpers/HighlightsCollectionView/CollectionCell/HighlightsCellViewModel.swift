//
//  HighlightsCellViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
//import DatabaseKit

class HighlightsCellViewModel {

    // MARK: - Properties

    private let audio: String
    var iconManager: CellIconManager

    // MARK: - Init

    init(audio: String) {
        self.audio = audio
        self.iconManager = CellIconManager.shared
    }

    // MARK: - Icon manager

    //    Changes the play status of a given cell
    func changePlayStatus() {
        print("TAAAPEDD")
    }

}
