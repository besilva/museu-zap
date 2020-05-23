//
//  CellIconManagerDelegate.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 14/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol CellIconManagerDelegate: class {
    func updateCellStatus(visible: Bool, audioPath: String, cell: AudioCell)
}
