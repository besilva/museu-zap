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
        contentView.backgroundColor = viewModel?.backgroundColor?.withAlphaComponent(viewModel!.opacity)
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
            view.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 64).isActive = true
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
//        cell.layer.masksToBounds = false
        layer.cornerRadius = 16
        
        //        Adds shadow
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.lightGray.cgColor//UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
        
        
//        contentViewMailLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
//        contentViewMailLabel.layer.shadowOpacity = 1
//        contentViewMailLabel.layer.shadowRadius = 20
//        contentViewMailLabel.layer.shadowOffset = CGSize(width: 0, height: 4)
        
//        self.contentView.layer.borderWidth = 1.0
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
//
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 0.5
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        changeColor()
    }
    
}
