//
//  SearchResultsViewModelMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
@testable import MuseuZap

class MockSearchResultsViewModel: SearchResultsViewModelProtocol {
    // MARK: - Properties
    var searchResultArray = [Audio]()
    var audios = AudioMock()
    var arrayCount: AudioCount = .all {
        didSet {
            loadSearchArray()
        }
    }

    enum AudioCount {
        case all
        case onePrivate
    }

    init() {
        loadSearchArray()
    }

    // MARK: - Audio

    // Function is equal to its original
    func getSearchedAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        let element = searchResultArray[indexPath.row]

        return AudioProperties(from: element)
    }

    // MARK: - Helper

    func loadSearchArray() {
        switch arrayCount {
        case .all:
            searchResultArray = [audios.audioPrivate, audios.audioPublic, audios.searchAudio]
        case .onePrivate:
            searchResultArray = [audios.audioPrivate]
        }
    }
}
