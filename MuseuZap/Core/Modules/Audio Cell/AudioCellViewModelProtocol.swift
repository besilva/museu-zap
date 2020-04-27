//
//  CellViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol AudioCellViewModelProtocol {
    var navigationDelegate: NavigationDelegate? { get }
    var title: String { get set }
    var audioURL: String { get set }
    var duration: TimeInterval { get set }
    var playing: Bool { get set }
    func back()
    func changePlayStatus()
    func share()
    
    init(title: String, duration: TimeInterval, audioURL: String)
    init(audioURL: String)
}
