//
//  HighlightsCellViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class HighlightsCellViewModel {

    // MARK: - Properties

    let audio: Audio
    var iconManager: CellIconManager
    var image: UIImage

    // MARK: - Init

    init(audio: Audio) {
        self.audio = audio
        self.iconManager = CellIconManager.shared
        self.image = UIImage()

        updateHighlightImage()
    }

    // MARK: - Icon manager

    //    Changes the play status of a given cell
    func changePlayStatus(cell: HighlightsCell) {
        iconManager.changePlayStatus(audioPath: audio.audioPath, cell: cell)
    }

    // MARK: - Update highlight image

    func updateHighlightImage() {
        switch audio.audioName {
        case "Seu Armando":
            self.image = UIImage.Highlights.armando!
        case "Ivan tentando vender queijos":
            self.image = UIImage.Highlights.ivan!
        case "Três conchada de galinha!":
            self.image = UIImage.Highlights.galinha!
        default:
            print("COULD NOT GET highlight image! \n")
        }
    }

}
