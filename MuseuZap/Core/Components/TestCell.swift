//
//  TestCell.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class TestCell: UITableViewCell, ViewCodable {
    func render() {
        
    }
    
//    var container: UIView = UIView()
    let categoryCollection: CategoryCollectionView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.0
        layout.scrollDirection = .horizontal
        categoryCollection = CategoryCollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
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

        categoryCollection.viewModel = CategoryCollectionViewModel(service: AudioCategoryServices())
//        categoryCollection.setupConstraints { (collection) in
//            collection.heightAnchor.constraint(equalToConstant: 200).isActive = true
//            collection.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0).isActive = true
//            collection.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0).isActive = true
//            collection.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
//            collection.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0).isActive = true
//        }
    }

}
