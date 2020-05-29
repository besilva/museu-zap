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
    var audios = MockAudio()

    init() {
        searchResultArray = [audios.audioPrivate, audios.audioPublic, audios.searchAudio]
    }
    // MARK: - Audio

    func getSearchedAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        return AudioProperties(from: audios.audioPublic)
    }
}
