//
//  CategoryTableViewController.swift
//  MuseuZapShare
//
//  Created by Bernardo Silva on 30/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import Database

protocol CategoryTableViewControllerDelegate: class {
    func categorySelected(category: AudioCategory)
}

class CategoryTableViewController: UITableViewController {
    weak var delegate: CategoryTableViewControllerDelegate?
    var categories: [AudioCategory] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let categoryService = AudioCategoryServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         categoryService.getAllCategories({ (_, categories) in // error, categories
            if let categories = categories {
                self.categories = categories
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = categories[indexPath.row].categoryName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.categorySelected(category: categories[indexPath.row])
    }
}
