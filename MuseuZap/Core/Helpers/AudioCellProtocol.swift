//
//  AudioCellProtocol.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

/// Protocol to allow Cell Icon Manager to change both AudioCell and Highlights cell icons
protocol AudioCellProtocol: class {

    var isPlaying: Bool { get set }
    var playImage: UIImage { get set }
    var pauseImage: UIImage { get set }
    var audioPath: String { get set }
}
