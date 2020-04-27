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
    
    var viewModel: ListViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loader = UIActivityIndicatorView(style: .gray)
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
        tableView.setupConstraints { (tableView) in
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
        loader.setupConstraints { (loader) in
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    func render() {
        createLoader()
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
}

extension ListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "test")
        let audio = viewModel.getAudioTable(at: indexPath)

        cell.textLabel?.text = audio.name + "   \(audio.category ?? "nil category")"
        cell.detailTextLabel?.text = audio.path

        return cell
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
    
}
