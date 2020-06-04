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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.register(PublicCategoryTableViewCell.self, forCellReuseIdentifier: "category")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as? PublicCategoryTableViewCell {
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
