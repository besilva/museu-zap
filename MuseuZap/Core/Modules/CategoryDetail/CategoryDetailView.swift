//
//  CategoryDetailView.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 05/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit
class CategoryDetailView: ListView {
    
    let category: AudioCategory
    private var headerDetailIdentifier: String = "detailHeaderCell"
    
    init(category: AudioCategory) {
        self.category = category
        super.init(frame: .zero)
        self.tableView.register(HeaderCategoryDetailCell.self, forCellReuseIdentifier: self.headerDetailIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard category.audios?.count ?? 0 > 0 else { return 0 }
        if section == 0 {
            return 1
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: headerDetailIdentifier, for: indexPath) as? HeaderCategoryDetailCell {
                let viewModel = HeaderCategoryDetailCellViewModel(category: self.category)
                cell.viewModel = viewModel
                return cell
            }
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        return UITableViewCell()
    }

}
