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
    
    init(category: AudioCategory) {
        self.category = category
        super.init(frame: .zero)
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 150
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderCategoryDetail()
        let viewModel = HeaderCategoryDetailViewModel(category: self.category)
        header.viewModel = viewModel
        return header
    }

}
