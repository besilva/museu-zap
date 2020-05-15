////
////  CellIconManagerProtocol.swift
////  MuseuZap
////
////  Created by Ignácio Espinoso Ribeiro on 15/05/20.
////  Copyright © 2020 Bernardo. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//protocol CellIconManagerProtocol {
//    var playStatus: State
//    var subjectCell: AudioCell?
//    var isCellVisible: Bool
//
//    /// Singleton
//    static var shared = CellIconManager()
//
//    init()
//    
//    func playbackDidStart(_ notification: Notification) {
//        guard let audioPath = notification.object as? String else {
//            let object = notification.object as Any
//            assertionFailure("Invalid object: \(object)")
//            return
//        }
//        
//        self.playStatus = State.playing(audioPath)
//    }
//    
//    @objc func playbackDidStop(_ notification: Notification) {
//        guard let audioPath = notification.object as? String else {
//            let object = notification.object as Any
//            assertionFailure("Invalid object: \(object)")
//            return
//        }
//        
//        self.playStatus = State.paused(audioPath)
//    }
//    
//    @objc func playbackDidEnd(_ notification: Notification) {
//        self.playStatus = State.idle
//    }
//    
//    func changePlayStatus(audioPath: String, cell: AudioCell) {
//        if self.subjectCell != cell && self.subjectCell != nil {
//            self.subjectCell!.isPlaying = false
//        }
//        self.subjectCell = cell
//        let audioURL = URL(fileURLWithPath: audioPath)
//        do {
//           try AudioManager.shared.changePlayerStatus(for: audioURL)
//       } catch {
//           print(error)
//       }
//    }
//}
//
//extension CellIconManager {
//    func updateCellStatus(visible: Bool, cell: AudioCell) {
//        
//        // If given cell is visible
//        if visible {
//            guard let audioPath = cell.viewModel?.audioPath else {
//                cell.isPlaying = false
//                return
//            }
//            // If my current state is playing the same audio as the current cell
//            switch self.playStatus {
//            case .playing(let playingPath):
//                if playingPath == audioPath {
//                    // Set play status for target cell
//                    cell.isPlaying = true
//                }
//            default:
//                // Set pause status for target cell
//                cell.isPlaying = false
//            }
//        }
//    }
//}
//
//extension CellIconManagerProtocol {
//    deinit {
//       AudioManager.shared.notificationCenter.removeObserver(self)
//    }
//}
