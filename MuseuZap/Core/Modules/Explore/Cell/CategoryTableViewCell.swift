//
//  CategoryTableViewCell.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class CategoryTableViewCell: UITableViewCell, ViewCodable {
    
//    var container: UIView = UIView()
    let categoryCollection: CategoryCollectionView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.0
        layout.scrollDirection = .horizontal
        categoryCollection = CategoryCollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        categoryCollection.viewModel = CategoryCollectionViewModel(service: AudioCategoryServices())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
//        container.addSubview(categoryCollection)
        contentView.addSubview(categoryCollection)
    }
    
    func setupConstraints() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        categoryCollection.setupConstraints { (view) in
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        }
    }

    func render() {
        
    }
}
