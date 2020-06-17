//
//  PrivateCategoryTableViewCell.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class PrivateCategoryTableViewCell: UITableViewCell, ViewCodable, CategoryTableViewCellProtocol {
    var categoryCollection: CategoryCollectionView
    var categories: [AudioCategory] = [] {
        didSet {
            self.categoryCollection.viewModel?.categories = self.categories
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.0
        layout.scrollDirection = .horizontal
        categoryCollection = PrivateCategoryCollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewModel()
        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAction(action: @escaping ((AudioCategory) -> Void)) {
        self.categoryCollection.action = action
    }
    
    func setupViewModel() {
         categoryCollection.viewModel = PrivateCategoryCollectionViewModel(service: AudioCategoryServices())
    }
    
    func setupConstraints() {
        categoryCollection.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        categoryCollection.setupConstraints { (view) in
            view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        }
        
        func render() {
            self.layer.masksToBounds = false
        }
    }
}
