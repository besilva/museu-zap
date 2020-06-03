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
    let numberOfAudiosLabel: UILabel
    var iconWidthConstraint: NSLayoutConstraint?
    var iconHeightConstraint: NSLayoutConstraint?
    var viewModel: CategoryCellViewModel? {
        didSet {
            render()
            configure()
            setupIcon()
        }
    }
     
    init() {
        iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "play")
        titleLabel = UILabel()
        numberOfAudiosLabel =  UILabel()
        titleLabel.text = "teste"
        numberOfAudiosLabel.text = "1000 audios"
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        iconImageView = UIImageView()
        titleLabel = UILabel()
        numberOfAudiosLabel =  UILabel()
        numberOfAudiosLabel.text = "1000 audios"
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIcon() {
        guard let width = viewModel?.icon?.size.width,
        let height = viewModel?.icon?.size.height else { return }
        iconWidthConstraint?.constant = width
        iconHeightConstraint?.constant = height
    }
    
    private func changeColor() {
        backgroundColor = viewModel?.backgroundColor?.withAlphaComponent(viewModel!.opacity)

    }
}

extension CategoryCell {
    
    func configure() {
        guard let viewModel = viewModel else { return }
        iconImageView.image = viewModel.icon
        titleLabel.text = viewModel.title
    }
    
    func setupHierarchy() {
        contentView.addSubviews(iconImageView, titleLabel, numberOfAudiosLabel)
    }
    
    func setupConstraints() {
        iconImageView.setupConstraints(completion: { (view) in
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            self.iconHeightConstraint = view.heightAnchor.constraint(equalToConstant: 32)
            self.iconHeightConstraint?.isActive = true
            self.iconWidthConstraint = view.widthAnchor.constraint(equalToConstant: 32)
            self.iconWidthConstraint?.isActive = true
        }, activateAll: true)
        
        titleLabel.setupConstraints(completion: { (view) in
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            view.topAnchor.constraint(
                lessThanOrEqualTo: iconImageView.bottomAnchor,
                constant: 64)
            .isActive = true
            view.bottomAnchor.constraint(equalTo: numberOfAudiosLabel.topAnchor, constant: -8).isActive = true
        }, activateAll: true)
        
        numberOfAudiosLabel.setupConstraints { (view) in
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
            view.heightAnchor.constraint(equalToConstant: 13).isActive = true
        }
    }
    
    func render() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.Default.label
        titleLabel.font = UIFont.Default.semibold
        
        numberOfAudiosLabel.numberOfLines = 1
        numberOfAudiosLabel.textColor = UIColor.Default.lightLabel
        numberOfAudiosLabel.font = UIFont.Default.regular.withSize(12)
        
        changeColor()
        
        layer.cornerRadius = 16
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        changeColor()
    }
    
}
