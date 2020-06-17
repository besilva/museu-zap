//
//  HighlightsCollectionViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit

// TODOO: desenhar, rever pra quem é o que pra quem quem que é o que de quem

protocol HighlightsCollectionViewModelDelegate: class {
    func reloadCollectionData()
}

protocol HighlightsCollectionViewModelProtocol {
    var delegate: HighlightsCollectionViewModelDelegate? { get set }
    var tableViewDelegate: HighlightsTableViewCellDelegate? { get set }
    var highlightedAudios: [Audio] { get set }
    func updateCurrentPage(toPage: Int)
}

class HighlightsCollectionViewModel: HighlightsCollectionViewModelProtocol {

    weak var delegate: HighlightsCollectionViewModelDelegate?
    weak var tableViewDelegate: HighlightsTableViewCellDelegate?
    var service: AudioServicesProtocol
    var highlightedAudios: [Audio]

    init(service: AudioServicesProtocol) {
        self.service = service
        highlightedAudios = []
        retrieveAllHighlightedAudios()
    }

    public convenience init () {
        self.init(service: AudioServices())
    }

    // MARK: - Methods

    func updateCurrentPage(toPage page: Int) {
        tableViewDelegate?.updatePageControlToPage(toPage: page)
    }

    func retrieveAllHighlightedAudios() {
        service.getAllAudios { (error, audios) in
            if let error = error {
                print(error, "COULD NOT GET HIGHLIGHTED AUDIOS")
            } else if let audioArray = audios {
                self.highlightedAudios = self.filterHighlights(array: audioArray)
            }
        }

    }

    func filterHighlights(array: [Audio]) -> [Audio] {
        var filtered: [Audio] = []
        let highlights = [
            Constants.highlightArmando,
            Constants.highlightIvan,
            Constants.highlightGalinha
        ]

        filtered = array.filter { (audio) -> Bool in
            highlights.contains(audio.audioName)

        }

        return filtered
    }

}
