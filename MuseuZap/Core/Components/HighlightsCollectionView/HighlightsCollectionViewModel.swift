//
//  HighlightsCollectionViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
//import DatabaseKit

protocol HighlightsCollectionViewModelDelegate: class {
    func reloadCollectionData()
}

protocol HighlightsCollectionViewModelProtocol {
    var delegate: HighlightsCollectionViewModelDelegate? { get set }
    var highlightedAudios: [String] { get set }

}

class HighlightsCollectionViewModel: HighlightsCollectionViewModelProtocol {

    weak var delegate: HighlightsCollectionViewModelDelegate?
    var highlightedAudios: [String] = ["1", "2", "3", "4"]

}
