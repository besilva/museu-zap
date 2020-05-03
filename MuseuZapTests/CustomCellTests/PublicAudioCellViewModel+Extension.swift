//
//  PublicAudioCellViewModelHelper.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 03/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
@testable import MuseuZap

extension PublicAudioCellViewModel {
    struct Helper {
        static let oneLine = PublicAudioCellViewModel(title: "Laboris cupidatat",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
        static let twoLines = PublicAudioCellViewModel(title: "Laboris cupidatat exercitation",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
        static let threeLines = PublicAudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
        static let fourLines = PublicAudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident Laboris cupidatat exercitation",
                                                        duration: 90,
                                                        audioURL: "sampleURL")
    }
}
