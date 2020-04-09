//
//  ListViewController.swift
//  MVVM-POC
//
//  Created by Bernardo Silva on 01/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController{
    private var loader: UIActivityIndicatorView!
    private var tableView: UITableView = UITableView()
    
    var viewModel: ListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoader()
        setupUI()
        setupTableView()
        viewModel?.getAllAudios()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        guard parent != nil else {
            viewModel?.back()
            return
        }
    }
    
    func createLoader() {
        loader = UIActivityIndicatorView(style: .gray)
        loader.center = self.view.center
        loader.startAnimating()
        loader.hidesWhenStopped = true
        self.view.addSubview(loader)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "test")
        let audio = viewModel.getAudiot(at: indexPath)
        cell.textLabel?.text = audio.title
        cell.detailTextLabel?.text = audio.subtitle
        return cell
    }
}

extension ListViewController: ListViewModelDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
    
    
}
