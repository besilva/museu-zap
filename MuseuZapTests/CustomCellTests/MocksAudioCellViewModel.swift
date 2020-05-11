//
//  MocksAudioCellViewModel.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 11/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
@testable import MuseuZap

class MockAudioCellViewModel: AudioCellViewModelProtocol {
    var navigationDelegate: NavigationDelegate?
    
    var title: String
    
    var audioPath: String
    
    var duration: TimeInterval
    
    var playing: Bool
    
    var actionHandler: (Action) -> Void
    
    var throwError: Bool = false
    var delayRequest: Bool = false
    
    func changePlayStatus(completion: ((Error?) -> Void)?) {
    //        Sends handler a play action, containing current audio path
            actionHandler(.play(audioPath, { _ in
    //            If play action occurred successfully, changes play status and
    //            calls completion with no errors
                if self.throwError == false {
                    self.playing = !self.playing
                    if let completion = completion {
                        completion(nil)
                    }
                } else {
    //                Calls completion with an error otherwise
                    let mockError = AudioCellError.ShareError
                    if let completion = completion {
                        completion(mockError)
                    }
                }
                
            }))
        }

    func share() {
        print(self.title)
        actionHandler(.share(audioPath))
        return
    }
    
    required init(title: String, duration: TimeInterval, audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.title = title
        self.duration = duration
        self.audioPath = audioPath
        self.playing = false
        actionHandler = audioHandler
    }
    
    required init(audioPath: String, audioHandler: @escaping (Action) -> Void) {
        self.audioPath = audioPath
        self.playing = false
        self.title = "Lorem Ipsum"
        self.duration = 90
        actionHandler = audioHandler
    }
}
