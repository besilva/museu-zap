//
//  SearchResultsCellViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 28/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class SearchResultsCellViewModel {

    var title: String
    var audioPath: String
    var duration: TimeInterval

    required init(title: String, duration: TimeInterval, audioPath: String) {
        self.title = title
        self.duration = duration
        self.audioPath = audioPath
    }

    required init(audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.audioPath = audioPath
        self.title = ""
        self.duration = 0
    }

    func changePlayStatus(cell: SearchResultsCell) {
       print("change play status")
    }
}
