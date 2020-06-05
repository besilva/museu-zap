//
//  AudioCellProtocol.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

// TODO: coloaar 2 delebgates da table view cell na collection (se ta mostando a celular)

/// Protocol to allow Cell Icon Manager to change both AudioCell and Highlights cell icons
protocol AudioCellProtocol: class {

    var isPlaying: Bool { get set }
    var playImage: UIImage { get set }
    var pauseImage: UIImage { get set }
    var audioPath: String { get set }
}

//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//

//    }
