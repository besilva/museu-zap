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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let categoriesAmount = Int(self.viewModel?.audioCategories.count ?? 2)
            return (categoriesAmount / 2)
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as? PrivateCategoryTableViewCell {
            let startIndex = 2*indexPath.row
            let endIndex = 2*indexPath.row + 2
            cell.categories = self.viewModel?.audioCategories ?? []
            cell.categories = Array(self.viewModel?.audioCategories[startIndex..<endIndex]  ?? [])
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
}
