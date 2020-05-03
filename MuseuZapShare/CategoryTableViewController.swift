//
//  CategoryTableViewController.swift
//  MuseuZapShare
//
//  Created by Bernardo Silva on 30/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol CategoryTableViewControllerDelegate: class {
    func categorySelected(category: String)
}

class CategoryTableViewController: UITableViewController {
    weak var delegate: CategoryTableViewControllerDelegate?
    var categories: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  TODO: Call to service
        categories = ["Teste", "Teste2"]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.categorySelected(category: categories[indexPath.row])
    }
}
