//
//  CategoryCell.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 20/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class CategoryCell: UICollectionViewCell, ViewCodable {
    
    let iconImageView: UIImageView
    let titleLabel: UILabel
    var viewModel: CategoryCellViewModel?
    
    init() {
        iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "play")
        titleLabel = UILabel()
        titleLabel.text = "teste"
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        iconImageView = UIImageView()
               iconImageView.image = UIImage(named: "play")
               titleLabel = UILabel()
               titleLabel.text = "teste"
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryCell {
    
    func setupHierarchy() {
        contentView.addSubviews(iconImageView, titleLabel)
    }
    
    func setupConstraints() {
        iconImageView.setupConstraints(completion: { (view) in
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            view.heightAnchor.constraint(equalToConstant: 32).isActive = true
            view.widthAnchor.constraint(equalToConstant: 32).isActive = true
        }, activateAll: true)
        
        titleLabel.setupConstraints(completion: { (view) in
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
            view.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 64).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 32).isActive = true
        }, activateAll: true)
    }
    
    func render() {
        titleLabel.numberOfLines = 0
        self.backgroundColor = UIColor.Default.power
    }
    
}
