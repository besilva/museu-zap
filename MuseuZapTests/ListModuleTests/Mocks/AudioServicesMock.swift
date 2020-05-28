//
//  AudioServicesMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

class AudioServicesMock: AudioServicesProtocol {

    var audio1 = Audio()
    var searchAudio = Audio()
    var exampleCategory = AudioCategory()

    enum MockCases {
        case setUp
        case onlyOneAudio
        case error
    }

    var stateCase: MockCases = .setUp

    init() {
        // Prepare audio
        exampleCategory.categoryName = "ListViewModelTests Category"

        audio1.audioName = "Audio 1"
        audio1.audioPath = FileManager.default.temporaryDirectory.path
        audio1.category = exampleCategory
        audio1.duration = 15
        audio1.isPrivate = true

        searchAudio.audioName = "Search Audio"
        searchAudio.audioPath = FileManager.default.temporaryDirectory.path
        searchAudio.category = exampleCategory
        searchAudio.duration = 10
        searchAudio.isPrivate = false
    }

    // MARK: - Functions

    func createAudio(audio: Audio, _ completion: ((Error?) -> Void)) {
        print("create")
    }

    func getAllAudios(_ completion: @escaping (Error?, [Audio]?) -> Void) {
        switch stateCase {
        case .setUp:
            completion(nil, [audio1, searchAudio])
        case .onlyOneAudio:
            // Load ViewModel array with 1 example audio
            completion(nil, [audio1])
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
