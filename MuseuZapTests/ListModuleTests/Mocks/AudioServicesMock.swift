//
//  AudioServicesMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

class AudioServicesMock: AudioServicesProtocol {

    var audios = AudioMock()
    var isCalled = false

    // MARK: - Functions

    func createAudio(audio: Audio, _ completion: ((Error?) -> Void)) {
    }

    func getAllAudios(_ completion: @escaping (Error?, [Audio]?) -> Void) {
        self.isCalled = true
        completion(nil, [audios.audioPrivate, audios.audioPublic, audios.searchAudio])
    }

    func getAllAudiosWith(isPrivate bool: Bool, _ completion: @escaping (Error?, [Audio]?) -> Void) {
        self.isCalled = true
        completion(nil, [audios.audioPublic])
    }

    func updateAllAudios(_ completion: (Error?) -> Void) {
    }

    func deleteAudio(audio: Audio, _ completion: (Error?) -> Void) {
    }
}
