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
    var viewModel: SearchResultsViewModelProtocol? {
        didSet {
            updateView()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.separatorStyle = .singleLine
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: self.cellIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetUp

    func configure() {
        setupTableView()
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
        tableView.dataSource = self
    }

    func updateView() {
        tableView.reloadData()
    }
}

    // MARK: - Table View

extension SearchResultsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? SearchResultCell {
             return cell
        }
        return UITableViewCell()
    }
}

    // MARK: - ViewModel

extension SearchResultsView: SearchResultsViewModelDelegate {

}
