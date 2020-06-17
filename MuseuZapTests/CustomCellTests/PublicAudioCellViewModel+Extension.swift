//
//  PublicAudioCellViewModelHelper.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 03/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
@testable import Blin
// swiftlint:disable line_length
extension AudioCellViewModel {
    struct Helper {
        static let oneLine = AudioCellViewModel(title: "Laboris cupidatat",
                                                duration: 90,
                                                audioPath: "sampleURL") { _ in
            return
        }
        static let twoLines = AudioCellViewModel(title: "Laboris cupidatat exercitation",
                                                 duration: 90,
                                                 audioPath: "sampleURL") { _ in
            return
        }
        static let threeLines = AudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident",
                                                   duration: 90,
                                                   audioPath: "sampleURL") { _ in
            return
        }
        static let fourLines = AudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident Laboris cupidatat exercitation",
                                                  duration: 90,
                                                  audioPath: "sampleURL") { _ in
            return
        }
    }
}
// swiftlint:enable line_length
