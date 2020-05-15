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
    }
    
    func setupHierarchy() {
        addSubviews(tableView, loader)
    }
    
    func createLoader() {
        loader.startAnimating()
        loader.hidesWhenStopped = true
    }
    
    func setupConstraints() {

        // TODO: fix constraints, error is beeing printed

        refreshControl.setupConstraints { (refresh) in
            refresh.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            refresh.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: -16).isActive = true
            refresh.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            refresh.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }

        tableView.setupConstraints { (tableView) in
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
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
        self.refreshControl.endRefreshing()
    }
}

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

}
