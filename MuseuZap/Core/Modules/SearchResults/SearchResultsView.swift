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
    var iconManager: CellIconManager = CellIconManager.shared
    var audioHandler: ((Action) -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.separatorStyle = .singleLine
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: self.cellIdentifier)

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
        guard let viewModel = viewModel else { return 0 }
        return viewModel.searchResultArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        let audio = viewModel.getSearchedAudioItemProperties(at: indexPath)

        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? SearchResultsCell {
            // Search results cell inherits from AudioCell, same viewModel is used
            let viewModel = AudioCellViewModel(title: audio.name, duration: audio.duration, audioPath: audio.path) { (action) in
                // Makes SearchResultsView handle actions performed by the audio cell view model
                if let audioHandler = self.audioHandler {
                    audioHandler(action)
                }
            }

            cell.viewModel = viewModel
            return cell
        }
        
        return UITableViewCell()
    }

    // MARK: - Change Icon

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

    // Avoid cell getting selected
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    // Avoid cell getting highlighted
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

    // MARK: - ViewModel

extension SearchResultsView: SearchResultsViewModelDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }

}
