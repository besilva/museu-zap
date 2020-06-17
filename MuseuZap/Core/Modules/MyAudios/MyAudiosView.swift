//
//  MyAudiosView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 01/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class MyAudiosView: ListView {
    override var viewModel: ListViewModelProtocol? {
        didSet {
            self.reloadTableView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.register(PrivateCategoryTableViewCell.self, forCellReuseIdentifier: "category")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // When there is no audios show place holder view
        guard let viewModel = viewModel, viewModel.count > 0 else { return 0 }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let categoriesAmount = Int(self.viewModel?.audioCategories.count ?? 0)
            return (categoriesAmount / 2)
        } else {
            guard let viewModel = self.viewModel as? MyAudiosViewModel else { return 0 }
            return viewModel.audiosWithoutCategories.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as? PrivateCategoryTableViewCell {
            let startIndex = 2*indexPath.row
            let endIndex = 2*indexPath.row + 2
            cell.categories = self.viewModel?.audioCategories ?? []
            cell.categories = Array(self.viewModel?.audioCategories[startIndex..<endIndex]  ?? [])
            cell.setupAction { (category) in
                self.viewModel?.navigationDelegate?.handleNavigation(action: .category(category))
            }
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func render() {
        super.render()
        self.layer.masksToBounds = false
        self.tableView.layer.masksToBounds = false
    }
    
    override func setupConstraints() {
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
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
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
}
