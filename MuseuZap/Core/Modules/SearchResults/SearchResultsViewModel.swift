//
//  SearchResultsViewModel.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit
import UIKit

protocol SearchResultsViewModelDelegate: class {
    func reloadTableView()
}

/// Protocol used so that from viewController ListViewModel (who handles search logic) can access searchResultArray
protocol SearchResultsViewModelProtocol {
    var searchResultArray: [Audio] { get set }
    func getSearchedAudioItemProperties(at indexPath: IndexPath) -> AudioProperties
}

class SearchResultsViewModel: SearchResultsViewModelProtocol {
    // MARK: - Properties
    var searchResultArray = [Audio]()
    var searchCount: Int {
        return searchResultArray.count
    }
    internal weak var delegate: SearchResultsViewModelDelegate?

    // MARK: - Init
    required init(delegate: SearchResultsViewModelDelegate) {
        self.delegate = delegate
    }

    // MARK: - Audio

    func getSearchedAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        let element = searchResultArray[indexPath.row]

        return AudioProperties(from: element)
    }
}
