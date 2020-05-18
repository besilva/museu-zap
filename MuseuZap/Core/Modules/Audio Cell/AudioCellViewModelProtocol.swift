//
//  CellViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol AudioCellViewModelDelegate: class {
    func updateIcon()
}

protocol AudioCellViewModelProtocol {
    var navigationDelegate: NavigationDelegate? { get }
    var delegate: AudioCellViewModelDelegate? { get set }
    var title: String { get set }
    var audioPath: String { get set }
    var duration: TimeInterval { get set }
    var actionHandler: (Action) -> Void { get set }
    var iconManager: CellIconManager { get }
    func changePlayStatus(cell: AudioCell)
    func share()
    
    init(title: String, duration: TimeInterval, audioPath: String, audioHandler: @escaping (Action) -> Void)
    init(audioPath: String, audioHandler: @escaping (Action) -> Void)
}
