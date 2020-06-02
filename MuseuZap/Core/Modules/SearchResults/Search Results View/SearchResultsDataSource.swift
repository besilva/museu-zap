//
//  SearchResultsDataSource.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 29/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, UITableViewDataSource {

    // MARK: - Init

    var viewModel: SearchResultsViewModelProtocol
    var cellIdentifier: String

    init(viewModel: SearchResultsViewModelProtocol, withIdentifier identifier: String) {
        self.viewModel = viewModel
        self.cellIdentifier = identifier
    }

    // MARK: - Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let audio = viewModel.getSearchedAudioItemProperties(at: indexPath)

        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? SearchResultsCell {
            // Search results cell inherits from AudioCell, same viewModel is used
            let viewModel = AudioCellViewModel(title: audio.name, duration: audio.duration, audioPath: audio.path) { ( _ ) in } // Action
            // Action is used only to share, CellIconManager deals with audio changes

            cell.viewModel = viewModel
            return cell
        }

        return UITableViewCell()
    }
}
