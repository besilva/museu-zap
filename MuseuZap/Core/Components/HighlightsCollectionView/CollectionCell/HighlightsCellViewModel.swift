//
//  HighlightsCellViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

protocol HighlightsCellViewModelProtocol {
    var audio: Audio { get set }
    var image: UIImage { get set }
    func changePlayStatus(cell: HighlightsCell)
}

class HighlightsCellViewModel: HighlightsCellViewModelProtocol {

    // MARK: - Properties

    var audio: Audio
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
        case Constants.highlightArmando:
            self.image = UIImage.Highlights.armando!
        case Constants.highlightIvan:
            self.image = UIImage.Highlights.ivan!
        case Constants.highlightGalinha:
            self.image = UIImage.Highlights.galinha!
        default:
            print("COULD NOT GET highlight image! \n")
        }
    }

}
