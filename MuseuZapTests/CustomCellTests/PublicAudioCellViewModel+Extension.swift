//
//  PublicAudioCellViewModelHelper.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 03/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
@testable import MuseuZap

extension AudioCellViewModel {
    struct Helper {
        static let oneLine = AudioCellViewModel(title: "Laboris cupidatat",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
        static let twoLines = AudioCellViewModel(title: "Laboris cupidatat exercitation",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
        static let threeLines = AudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
        static let fourLines = AudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident Laboris cupidatat exercitation",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
    }
}
// swiftlint:enable line_length
