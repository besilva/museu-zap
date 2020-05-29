//
//  SearchResultsCellViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 28/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class SearchResultsCellViewModel {

    // MARK: - Properties

    var title: String
    var audioPath: String
    var duration: TimeInterval

    var iconManager: CellIconManager = CellIconManager.shared
    var actionHandler: (Action) -> Void

    // MARK: - Init

    required init(title: String, duration: TimeInterval, audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.title = title
        self.duration = duration
        self.audioPath = audioPath
        actionHandler = audioHandler
    }

    required init(audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.audioPath = audioPath
        self.title = "Lorem Ipsum"
        self.duration = 90
        actionHandler = audioHandler
    }

    // MARK: - Action

    func changePlayStatus(cell: SearchResultsCell) {
//       iconManager.changePlayStatus(audioPath: audioPath, cell: cell)
    }
}
