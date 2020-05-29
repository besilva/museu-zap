//
//  SearchResultsView.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class SearchResultsView: UIView, ViewCodable {

    // MARK: - Properties

    private var cellIdentifier: String = "searchCell"
    private var tableView: UITableView = UITableView()
    private var dataSource: SearchResultsDataSource!
    var viewModel: SearchResultsViewModelProtocol? {
        didSet {
            // Create data source only when viewModel was set
            // Then setUp table view
            dataSource = SearchResultsDataSource(viewModel: viewModel!, withIdentifier: cellIdentifier)
            updateView()
        }
    }
    var iconManager: CellIconManager = CellIconManager.shared

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetUp

    func configure() {
        // TableView will be configured when dataSource is set
    }

    func setupHierarchy() {
        addSubviews(tableView)
    }

    func setupConstraints() {

        tableView.setupConstraints { (tableView) in
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }
        
    }
    
    func render() {
        self.backgroundColor = UIColor.Default.background
    }

    // MARK: - SetUp Helpers

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.separatorStyle = .singleLine
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }

    func updateView() {
        setupTableView()
        tableView.reloadData()
    }
}

    // MARK: - Table View

// Data Source comes from SearchResultsDataSource
extension SearchResultsView: UITableViewDelegate {

    // Avoid cell getting selected
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    // Avoid cell getting highlighted
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    // MARK: Change Icon

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let audioCell = cell as? SearchResultsCell else {
            return
        }
        iconManager.updateCellStatus(visible: true, cell: audioCell)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let audioCell = cell as? SearchResultsCell else {
            return
        }
        iconManager.updateCellStatus(visible: false, cell: audioCell)
    }
}

    // MARK: - ViewModel

extension SearchResultsView: SearchResultsViewModelDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}
