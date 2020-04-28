//
//  MyLibCellViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class MyLibAudioCellViewModel: AudioCellViewModelProtocol {
    var navigationDelegate: NavigationDelegate?
    var title: String
    var audioURL: String
    var duration: TimeInterval
    var playing: Bool {
        didSet {
            // TODO: Change play icon on view
        }
    }
    
    required init(title: String, duration: TimeInterval, audioURL: String) {
        self.title = title
        self.duration = duration
        self.audioURL = audioURL
        self.playing = false
    }
    
    required init(audioURL: String) {
        self.audioURL = audioURL
        self.playing = false
        // TODO: Call to API function to retrieve audio data
        self.title = "Lorem Ipsum"
        self.duration = 90
    }
    
    func changePlayStatus() {
        playing = !playing
//        TODO: Call media manager singleton to change play status
    }
    
    func share() {
        // TODO: Call to navigation delegate to share action
        return
    }
}
