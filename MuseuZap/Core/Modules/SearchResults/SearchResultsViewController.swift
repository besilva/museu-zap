//
// SearchResultsViewController.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import CoreData
import DatabaseKit

class SearchResultsViewController: UIViewController {

    // MARK: - Properties

    /// Reference to SearchResultsViewModel so ListViewModel can reach searchResultArray
    var model: SearchResultsViewModelProtocol?
    /// Reference to SearchResultsView so ListViewModel can reach tableView.reloadData()
    weak var viewDelegate: SearchResultsViewModelDelegate?

    private var myView: SearchResultsView {
        // swiftlint:disable force_cast
        return view as! SearchResultsView
        // swiftlint:enable force_cast
    }

    // MARK: - Life Cycle

    override func loadView() {
        let myView = SearchResultsView()
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = SearchResultsViewModel()
        myView.viewModel = viewModel
        model = viewModel
        viewDelegate = myView
    }
}
