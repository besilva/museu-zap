//
//  MyLibCellViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AudioCellViewModel: AudioCellViewModelProtocol {
    weak var navigationDelegate: NavigationDelegate?
    internal weak var delegate: AudioCellViewModelDelegate?
    var iconManager: CellIconManager = CellIconManager.shared
    var title: String
    var audioPath: String
    var duration: TimeInterval
    var actionHandler: (Action) -> Void
    
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
    
//    Changes the play status of a given cell
    func changePlayStatus(cell: AudioCell) {
        iconManager.changePlayStatus(audioPath: audioPath, cell: cell)
    }
    
//    Shares a given cell audio, using its path
    func share() {
        print(self.title)
        actionHandler(.share(audioPath))
        return
    }
}
