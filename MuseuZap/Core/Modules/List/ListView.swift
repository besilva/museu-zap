//
//  ListView.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListView: UIView, ViewCodable {

    private var loader: UIActivityIndicatorView!
    private var tableView: UITableView = UITableView()
    private var cellIdentifier: String = "cell"
    var iconManager: CellIconManager = CellIconManager.shared
    var audioHandler: ((Action) -> Void)?
    var viewModel: ListViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        // For some reason, leaving tintColor = UIColor.default.power is "more red" than normal in darkMode.
        // Power color is UIColor(red: 1, green: 0, blue: 0.57, alpha: 1), so letting tintColor little bit less red works
        refreshControl.tintColor = UIColor.Default.powerRefresh

        return refreshControl
    }()
    /// This constrain needs to be deativated when scrolling down
    var refreshScrollConstraint: NSLayoutConstraint!
    var searchController: UISearchController!
    /// TopBarHeight from viewController will be used to auto-layout the refreshControl
    var topBarHeight: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        loader = UIActivityIndicatorView(style: .gray)
        loader.hidesWhenStopped = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        tableView.separatorStyle = .none
        tableView.register(AudioCell.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.insertSubview(refreshControl, at: 0)

        let searchManager = SearchResultsViewController()
        searchController = UISearchController(searchResultsController: searchManager)
        searchController.searchResultsUpdater = searchManager
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Buscar áudio"
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configure() {
        setupTableView()
    }

    func setupHierarchy() {
        addSubviews(tableView, loader)
    }

    func createLoader() {
        loader.startAnimating()
        loader.hidesWhenStopped = true
    }

    func setupConstraints() {

        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.setupConstraints { (refresh) in
            refresh.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            refresh.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            refresh.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }
        // Constraint will be true or false depending on the scroll delegate
        refreshScrollConstraint = refreshControl.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 0)
        refreshScrollConstraint.isActive = true

        tableView.setupConstraints { (tableView) in
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        }
        
        loader.setupConstraints { (loader) in
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
        
    }
    
    func render() {
        createLoader()
        self.backgroundColor = UIColor.Default.background
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
}

    // MARK: - Table View

extension ListView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        let audio = viewModel.getAudioItemProperties(at: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? AudioCell {
            
            let viewModel = AudioCellViewModel(title: audio.name, duration: audio.duration, audioPath: audio.path) { (action) in
//                Makes List View handle actions performed by the audio cell view model
                if let audioHandler = self.audioHandler {
                    audioHandler(action)
                }  
            }

            cell.viewModel = viewModel           
            return cell
            
        }
        return UITableViewCell()
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel?.handleRefresh()
    }
}

    // MARK: - ViewModel

extension ListView: ListViewModelDelegate {

    func reloadTableView() {
        tableView.reloadData()
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }

    func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
}

   // MARK: - Change Icon

extension ListView {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let audioCell = cell as? AudioCell else {
            return
        }
        iconManager.updateCellStatus(visible: true, cell: audioCell)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let audioCell = cell as? AudioCell else {
            return
        }
        iconManager.updateCellStatus(visible: false, cell: audioCell)
    }
}

    // MARK: - Scroll for refreshControl

// Without this, this constrain would break in order to scroll down
extension ListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y > 0 {
            // Scrolling down deactive constrain
            refreshScrollConstraint.isActive = false
        } else {
            // Scrolling up activate in order to pull to refresh
            refreshScrollConstraint.isActive = true
        }
    }
}
