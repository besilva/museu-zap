//
//  CategoryTableViewCell.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

protocol CategoryTableViewCellProtocol: UITableViewCell, ViewCodable {
    var categoryCollection: CategoryCollectionView {get set}
    func setupViewModel()
}

extension CategoryTableViewCellProtocol {
    func setupHierarchy() {
        contentView.addSubview(categoryCollection)
    }
    
    func render() { }
}

class PublicCategoryTableViewCell: UITableViewCell, ViewCodable, CategoryTableViewCellProtocol {

//    var container: UIView = UIView()
    var categoryCollection: CategoryCollectionView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.0
        layout.scrollDirection = .horizontal
        categoryCollection = CategoryCollectionView(frame: .zero, collectionViewLayout: layout)
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
         categoryCollection.viewModel = CategoryCollectionViewModel(service: AudioCategoryServices())
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

}
