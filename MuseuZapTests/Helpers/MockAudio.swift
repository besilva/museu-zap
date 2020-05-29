//
//  MockAudio.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

/// Simple Mocked audios to be used for testing purposes
class MockAudio {

    public var category1 = AudioCategory()
    public var category2 = AudioCategory()

    public var audioPublic = Audio()
    public var audioPrivate = Audio()

    public var searchAudio = Audio()

    init() {
        // Prepare audios
        category1.categoryName = "Category 1"
        category2.categoryName = "Category 2"

        audioPublic.audioName = "Audio Public"
        audioPublic.audioPath = FileManager.default.temporaryDirectory.path
        audioPublic.category = category1
        audioPublic.duration = 15
        audioPublic.isPrivate = false

        audioPrivate.audioName = "Audio Private"
        audioPrivate.audioPath = FileManager.default.temporaryDirectory.path
        audioPrivate.category = category2
        audioPrivate.duration = 10
        audioPrivate.isPrivate = false

        searchAudio.audioName = "Search"
        searchAudio.audioPath = FileManager.default.temporaryDirectory.path
        searchAudio.category = category1
        searchAudio.duration = 5
        searchAudio.isPrivate = false
    }
}
