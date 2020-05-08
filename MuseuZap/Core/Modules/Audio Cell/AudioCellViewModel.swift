//
//  MyLibCellViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AudioCellViewModel: AudioCellViewModelProtocol {
    weak var navigationDelegate: NavigationDelegate?
    var title: String
    var audioPath: String
    var duration: TimeInterval
    var playing: Bool
    var actionHandler: (Action) -> Void
    
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
        // TODO: Call to API function to retrieve audio data
        self.title = "Lorem Ipsum"
        self.duration = 90
        actionHandler = audioHandler
    }
    
    func changePlayStatus(completion: ((Error?) -> Void)?) {
//        Sends handler a play action, containing current audio path
        actionHandler(.play(audioPath, { error in
//            If play action occurred successfully, changes play status and
//            calls completion with no errors
            if error == nil {
                self.playing = !self.playing
                if let completion = completion {
                    completion(nil)
                }
            } else {
//                Calls completion with an error otherwise
                if let completion = completion {
                    completion(error)
                }
            }
            
        }))
    }
    
    func share() {
        print(self.title)
        actionHandler(.share(audioPath))
        return
    }
}
