//
//  ExploreView.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class ExploreView: ListView {
    private var highlightsCellIdentifier: String = "highlightsCell"
    private var categoriesCellIdentifier: String = "categoriesCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.register(HighlightsTableViewCell.self, forCellReuseIdentifier: self.highlightsCellIdentifier)
        self.tableView.register(PublicCategoryTableViewCell.self, forCellReuseIdentifier: self.categoriesCellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // When there is no audios show place holder view
        guard let viewModel = viewModel, viewModel.count > 0 else { return 0 }
        return 2 + (viewModel.audioCategories.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            let audios = viewModel?.audioCategories[section - 2].audios
            var numberOfAudios: Int
            if (audios?.count ?? 0) < 4 {
                numberOfAudios = (audios?.count ?? 0)
            } else {
                numberOfAudios = 4
            }
            return numberOfAudios + 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: highlightsCellIdentifier, for: indexPath) as? HighlightsTableViewCell {
                return cell
            }
        } else if indexPath.section == 1,
            let cell = tableView.dequeueReusableCell(withIdentifier: categoriesCellIdentifier, for: indexPath) as? PublicCategoryTableViewCell {
            cell.setupAction { (category) in
                self.viewModel?.navigationDelegate?.handleNavigation(action: .category(category))
            }
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = UITableViewCell()
                let header = SectionsHeaderView()
                header.viewModel = SectionsHeaderViewModel(category: viewModel?.audioCategories[indexPath.section - 2]) { category in
                    self.viewModel?.navigationDelegate?.handleNavigation(action: .category(category))
                }
                cell.addSubview(header)
                header.setupConstraints { (view) in
                    view.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
                    view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
                    view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
                }
                return cell
            }
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        return UITableViewCell()
    }
    
}
