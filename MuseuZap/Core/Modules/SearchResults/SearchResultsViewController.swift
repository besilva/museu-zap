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

    private var myView: SearchResultsView {
        // swiftlint:disable force_cast
        return view as! SearchResultsView
    }

    /// Reference to SearchResultsViewModel is used so ResultsCell can get  searchResultArray
    var model: SearchResultsViewModelProtocol?
    var viewDelegate: SearchResultsViewModelDelegate?

    override func loadView() {
        let myView = SearchResultsView()
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = SearchResultsViewModel(delegate: myView)
        myView.viewModel = viewModel
        model = viewModel
        viewDelegate = myView
    }

    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("oi")
    }
}
