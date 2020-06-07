//
//  CellIconManager.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 14/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import AVFoundation

class CellIconManager {
//    Updates icon when changing play status
    var playStatus: State {
        didSet {
            guard let audioCell = self.subjectCell else {
                return
            }
            self.updateCellStatus(visible: true, cell: audioCell)
        }
    }
    var subjectCell: AudioCellProtocol?
    var isCellVisible: Bool

    /// Singleton
    static let shared = CellIconManager()
    
//    Removes observers when deinitializing
    deinit {
        AudioManager.shared.notificationCenter.removeObserver(self)
     }
    
    init() {
        self.playStatus = .idle
        self.isCellVisible = false

//        Observes when playback starts
        AudioManager.shared.notificationCenter.addObserver(self,
            selector: #selector(playbackDidStart),
            name: .playbackStarted,
            object: nil
        )

//        Observe when playback pauses
        AudioManager.shared.notificationCenter.addObserver(self,
            selector: #selector(playbackDidStop),
            name: .playbackPaused,
            object: nil
        )

//        Observes when playback ends
        AudioManager.shared.notificationCenter.addObserver(self,
                     selector: #selector(playbackDidEnd),
                     name: .playbackStopped,
                     object: nil)
    }
    
//    Changes play status to play using given object as the audio path
    @objc func playbackDidStart(_ notification: Notification) {
        guard let audioPath = notification.object as? String else {
            let object = notification.object as Any
            assertionFailure("Invalid object: \(object)")
            return
        }
        
        self.playStatus = State.playing(audioPath)
    }
    
//    Changes play status to pause using given object as the audio path
    @objc func playbackDidStop(_ notification: Notification) {
        guard let audioPath = notification.object as? String else {
            let object = notification.object as Any
            assertionFailure("Invalid object: \(object)")
            return
        }
        
        self.playStatus = State.paused(audioPath)
    }

//    Changes play status to idle
    @objc func playbackDidEnd(_ notification: Notification) {
        self.playStatus = State.idle
    }
    
//    Handles play status change
    func changePlayStatus(audioPath: String, cell: AudioCellProtocol) {
//        If cell changed is not current monitored cell
        if self.subjectCell?.audioPath != cell.audioPath && self.subjectCell != nil {
            self.subjectCell!.isPlaying = false
        }
        self.subjectCell = cell
        let audioURL = URL(fileURLWithPath: audioPath)
        do {
           try AudioManager.shared.changePlayerStatus(for: audioURL)
       } catch {
           print(error)
       }
    }
}

extension CellIconManager {
    func updateCellStatus(visible: Bool, cell: AudioCellProtocol) {
        
        // If given cell is visible
        if visible {
//            guard let audioPath = cell.viewModel?.audioPath else {
//                cell.isPlaying = false
//                return
//            }
            let audioPath = cell.audioPath

            // If my current state is playing the same audio as the current cell
            switch self.playStatus {
            case .playing(let playingPath):
                if playingPath == audioPath {
                    // Set play status for target cell
                    cell.isPlaying = true
                }
            default:
                // Set pause status for target cell
                cell.isPlaying = false
            }
        }
    }
}
