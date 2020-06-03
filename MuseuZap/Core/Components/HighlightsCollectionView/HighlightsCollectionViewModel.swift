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
    var tableViewDelegate: HighlightsTableViewCellDelegate? { get set }
    var highlightedAudios: [String] { get set }
    func updateCurrentPage(toPage: Int)
}

class HighlightsCollectionViewModel: HighlightsCollectionViewModelProtocol {

    weak var delegate: HighlightsCollectionViewModelDelegate?
    weak var tableViewDelegate: HighlightsTableViewCellDelegate?
    var highlightedAudios: [String] = ["1", "2", "3", "4"]

    func updateCurrentPage(toPage page: Int) {
        tableViewDelegate?.updatePageControlToPage(toPage: page)
    }

}
