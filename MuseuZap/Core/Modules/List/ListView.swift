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
    var placeholderView: PlaceholderView = PlaceholderView()
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
        refreshControl.tintColor = UIColor.Default.power

        return refreshControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loader = UIActivityIndicatorView(style: .gray)
        loader.hidesWhenStopped = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        tableView.separatorStyle = .none
        tableView.register(AudioCell.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.insertSubview(refreshControl, at: 0)
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
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

        refreshControl.setupConstraints { (refresh) in
            refresh.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            refresh.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 0).isActive = true
            refresh.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            refresh.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }

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
        
        placeholderView.setupConstraints { (_) in
            placeholderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
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
    
}

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
        viewModel?.handleRefresh(refreshControl)
    }
}

extension ListView: ListViewModelDelegate {

    func reloadTableView() {
        tableView.reloadData()
        if self.viewModel?.count == 0  || self.viewModel == nil {
            self.tableView.isScrollEnabled = false
            self.tableView.backgroundView?.isHidden = false
        } else {
            self.tableView.isScrollEnabled = true
            self.tableView.backgroundView?.isHidden = true
        }
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

}

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

// MARK: Placeholder view
extension ListView {
    func setupPlaceholderView() {
        let title = "Você ainda não adicionou áudios.\nTá esperando o quê?! 😜"
        let subtitle = "No Blin/Pleen você pode organizar áudios do WhatsApp de acordo com categorias."
        let actionMessage = "Saiba como adicionar áudios"
        let actionURL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
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
