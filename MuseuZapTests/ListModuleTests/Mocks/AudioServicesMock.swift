//
//  AudioServicesMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

class AudioServicesMock: AudioServicesProtocol {

    var exampleAudio = Audio()
    var exampleCategory = AudioCategory()

    enum MockCases {
        case addOneMoreAudio
        case noError
        case error
    }

    var stateCase: MockCases = .noError

    func createAudio(audio: Audio, _ completion: ((Error?) -> Void)) {
        print("create")
    }

    func getAllAudios(_ completion: @escaping (Error?, [Audio]?) -> Void) {
        switch stateCase {
        case .addOneMoreAudio:
            // Load ViewModel array with 2 example audios
            completion(nil, [exampleAudio, exampleAudio])
        case .noError:
            completion(nil, [exampleAudio])
        case .error:
            print()
        }
    }

    func getAllAudiosWith(isPrivate bool: Bool, _ completion: @escaping (Error?, [Audio]?) -> Void) {
        print("getwith")
    }

    func updateAllAudios(_ completion: (Error?) -> Void) {
        print("update")
    }

    func deleteAudio(audio: Audio, _ completion: (Error?) -> Void) {
        print("delete")
    }

}
