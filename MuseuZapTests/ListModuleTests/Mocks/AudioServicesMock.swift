//
//  AudioServicesMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

class AudioServicesMock: AudioServicesProtocol {

    var audios = MockAudio()

    enum MockCases {
        case setUp // Contains 3 Audios
        case onlyOneAudio
        case error
    }

    var stateCase: MockCases = .setUp

    // MARK: - Functions

    func createAudio(audio: Audio, _ completion: ((Error?) -> Void)) {
    }

    func getAllAudios(_ completion: @escaping (Error?, [Audio]?) -> Void) {
        switch stateCase {
        // At setUp, load viewModel with 3 audios
        case .setUp:
            completion(nil, [audios.audioPrivate, audios.audioPublic, audios.searchAudio])
        // Load ViewModel array with 1 example audio
        case .onlyOneAudio:
            completion(nil, [audios.audioPublic])
        case .error:
            print()
        }
    }

    func getAllAudiosWith(isPrivate bool: Bool, _ completion: @escaping (Error?, [Audio]?) -> Void) {
    }

    func updateAllAudios(_ completion: (Error?) -> Void) {
    }

    func deleteAudio(audio: Audio, _ completion: (Error?) -> Void) {
    }
}
