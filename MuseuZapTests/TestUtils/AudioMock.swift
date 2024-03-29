//
//  AudioMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

/// Simple Mocked audios to be used for testing purposes
class AudioMock {

    public var category1 = AudioCategory()
    public var category2 = AudioCategory()

    public var audioPublic = Audio()
    public var audioPrivate = Audio()
    public var highlightAudio = Audio()
    public var searchAudio = Audio()

    public var audioArray: [Audio] = []

    init() {
        // Prepare audios
        category1.categoryName = "Engraçados"
        category1.assetIdentifier = "funny"
        category1.isPrivate = false
        category1.addToAudios(self.audioPublic)
        category2.categoryName = "Clássicos do Zap"
        category2.assetIdentifier = "classic"
        category2.isPrivate = false
        category2.addToAudios(self.audioPrivate)

        audioPublic.audioName = "Audio Public"
        audioPublic.audioPath = FileManager.default.temporaryDirectory.path
        audioPublic.category = category1
        audioPublic.duration = 15
        audioPublic.isPrivate = false
        
        audioPrivate.audioName = "Audio Private"
        audioPrivate.audioPath = FileManager.default.temporaryDirectory.path
        audioPrivate.category = category2
        audioPrivate.duration = 10
        audioPrivate.isPrivate = true

        highlightAudio.audioName = "Seu Armando"
        highlightAudio.audioPath = FileManager.default.temporaryDirectory.path
        highlightAudio.category = category2
        highlightAudio.duration = 1
        highlightAudio.isPrivate = true

        searchAudio.audioName = "Search"
        searchAudio.audioPath = FileManager.default.temporaryDirectory.path
        searchAudio.category = category1
        searchAudio.duration = 5
        searchAudio.isPrivate = false

        audioArray = [audioPublic, audioPrivate, highlightAudio, searchAudio]
    }
    
    internal func addPublicCategories() -> [AudioCategory] {
        return [category1, category2]
    }
}
