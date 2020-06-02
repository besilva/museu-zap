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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "category")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as? CategoryTableViewCell {
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
