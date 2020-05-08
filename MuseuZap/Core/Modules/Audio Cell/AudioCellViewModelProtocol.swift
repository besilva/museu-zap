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
    var audioPath: String { get set }
    var duration: TimeInterval { get set }
    var playing: Bool { get set }
    var actionHandler: (Action) -> Void { get set }
    func changePlayStatus(completion: ((Error?) -> Void)?)
    func share()
    
    init(title: String, duration: TimeInterval, audioPath: String, audioHandler: @escaping (Action) -> Void)
    init(audioPath: String, audioHandler: @escaping (Action) -> Void)
}
