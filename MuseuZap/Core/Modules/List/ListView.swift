//
//  ListView.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListView: UIView, ViewCodable {

    var loader: UIActivityIndicatorView!
    internal var tableView: UITableView = UITableView()
    var audioCellIdentifier: String = "audioCell"
    var placeholderView: PlaceholderView = PlaceholderView()
    var iconManager: CellIconManager = CellIconManager.shared
    var audioHandler: ((Action) -> Void)?
    var viewModel: ListViewModelProtocol? {
        didSet {
            setSearchController()
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
    /// TopBarHeight from viewController will be used to auto-layout the refreshControl and PlaceholderView
    var topBarHeight: CGFloat = 0
    var navBarHeight: CGFloat = 0 {
           // Calculate topBarHeight only when navBarHeight was set
           didSet {
            setRefreshAndPlaceholderTopAnchor()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loader = UIActivityIndicatorView(style: .gray)
        loader.hidesWhenStopped = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        tableView.separatorStyle = .none
        tableView.register(AudioCell.self, forCellReuseIdentifier: self.audioCellIdentifier)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.showsVerticalScrollIndicator = false

        // SearchController is configuered when viewModel is set

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
        setupPlaceholderView()
    }

    func setupHierarchy() {
        addSubviews(tableView, loader)
    }

    func createLoader() {
        loader.hidesWhenStopped = true
        loader.stopAnimating()
    }

    func setupConstraints() {

        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.setupConstraints { (refresh) in
            // Top anchor is only constructed at setRefreshTopAnchor
            // Bottom anchor is refreshScrollConstraint
            refresh.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            refresh.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }
        // Constraint will be true or false depending on the scroll delegate
        refreshScrollConstraint = refreshControl.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 0)
        // This bottom constraint will be set to true only when topBarHeight was calculated
        refreshScrollConstraint.isActive = false

        tableView.setupConstraints { (tableView) in
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.tableViewSpacing).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.tableViewSpacing).isActive = true
        }
        
        loader.setupConstraints { (loader) in
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
        
        placeholderView.setupConstraints { (_) in
            // Top anchor is only constructed at setRefreshAndPlaceholderTopAnchor
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
    }
    
    func render() {
        createLoader()
        self.backgroundColor = UIColor.Default.background
    }
    
    func updateView() {
        self.reloadTableView()
    }

    /// This is called only when viewModel is set
    func setSearchController() {
        // SearchManager will be used to display results, ListViewModel will handle search logic
        searchController = UISearchController(searchResultsController: viewModel?.searchManager)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Buscar áudio"
        searchController.searchBar.tintColor = UIColor.Default.power

        // Set SearchBar Button
       let attributes: [NSAttributedString.Key: Any] = [
           .font: UIFont.Default.regular.withSize(15)
       ]
       UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)

        // If available, modify searchBar font
        if #available(iOS 13, *) {
            searchController.searchBar.searchTextField.font = UIFont.Default.regular.withSize(15)
        }
    }
}
    // MARK: - Table View

extension ListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        let audio = viewModel.getAudioItemProperties(at: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.audioCellIdentifier, for: indexPath) as? AudioCell {

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

    // MARK: - Change Icon

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

    // Avoid cell getting selected
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    // Avoid cell getting highlighted
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

    // MARK: - Search

extension ListView: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel?.performSearch(with: text)
    }
}

    // MARK: - For ViewModel

extension ListView: ListViewModelDelegate {
    func reloadTableView() {
        tableView.reloadData()
        guard self.viewModel?.count == 0 || self.viewModel == nil else {
            self.tableView.isScrollEnabled = true
            self.tableView.backgroundView?.isHidden = true
            return
        }
        self.tableView.isScrollEnabled = false
        self.tableView.backgroundView?.isHidden = false
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.loader.startAnimating()
        }
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

// MARK: Placeholder view
extension ListView {
    func setupPlaceholderView() {
        let title = "Você ainda não adicionou áudios.\nTá esperando o quê?! 😜"
        let subtitle = "No Blin você pode organizar áudios do WhatsApp de acordo com categorias."
        let actionMessage = "Saiba como adicionar áudios"
        let actionURL = URL(string: "https://youtu.be/sxNcH6u3_h0")!
        let placeholderViewModel = PlaceholderViewModel(title: title,
                                                        subtitle: subtitle,
                                                        actionMessage: actionMessage,
                                                        actionURL: actionURL,
                                                        iconAssetName: "folder.fill.badge.plus")
        self.placeholderView.viewModel = placeholderViewModel
        self.tableView.backgroundView = self.placeholderView
        self.tableView.backgroundView?.isHidden = true
    }
}

   // MARK: - Refresh

extension ListView {

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel?.handleRefresh()
    }

    func setRefreshAndPlaceholderTopAnchor() {
        // Calculate topAnchor with topBarHeight updated
        topBarHeight = navBarHeight + searchController.searchBar.frame.height
        refreshControl.topAnchor.constraint(equalTo: self.topAnchor, constant: topBarHeight).isActive = true
        placeholderView.topAnchor.constraint(equalTo: self.topAnchor, constant: topBarHeight).isActive = true

        setNeedsUpdateConstraints()
    }
}

    // MARK: - Scroll for refreshControl

// Without this, this constrain would break in order to scroll down
extension ListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // Table view "starts" at topBarHeight
        // ListController extendedLayoutIncludesOpaqueBars was set to true so SearchResultsController could work properly
        if scrollView.contentOffset.y > (-topBarHeight) {
            // Scrolling down deactive constrain
            refreshScrollConstraint.isActive = false
        } else {
            // Scrolling up activate in order to pull to refresh
            refreshScrollConstraint.isActive = true
        }
    }
}
