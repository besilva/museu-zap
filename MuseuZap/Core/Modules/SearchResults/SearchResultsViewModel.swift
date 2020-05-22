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

}

protocol SearchResultsViewModelProtocol {

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

}
